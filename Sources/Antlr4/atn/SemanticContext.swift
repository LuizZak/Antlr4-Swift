///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

///
/// A tree structure used to record the semantic context in which
/// an ATN configuration is valid.  It's either a single predicate,
/// a conjunction `p1&&p2`, or a sum of products `p1||p2`.
///
/// I have scoped the _org.antlr.v4.runtime.atn.SemanticContext.AND_, _org.antlr.v4.runtime.atn.SemanticContext.OR_, and _org.antlr.v4.runtime.atn.SemanticContext.Predicate_ subclasses of
/// _org.antlr.v4.runtime.atn.SemanticContext_ within the scope of this outer class.
///

import Foundation

public enum SemanticContext: Hashable, CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .none:
            return "{-1:-1}?"
            
        case let .predicate(ruleIndex, predIndex, _):
            return "{\(ruleIndex):\(predIndex)}?"
            
        case .precedence(let precedence):
            return "{\(precedence)>=prec}?"
            
        case .operatorAnd(let opnds):
            return opnds.map({ $0.description }).joined(separator: "&&")
            
        case .operatorOr(let opnds):
            return opnds.map({ $0.description }).joined(separator: "||")
        }
    }
    
    case none
    case predicate(ruleIndex: Int, predIndex: Int, isCtxDependent: Bool)
    case precedence(Int)
    case operatorAnd([SemanticContext])
    case operatorOr([SemanticContext])
    
    ///
    /// For context independent predicates, we evaluate them without a local
    /// context (i.e., null context). That way, we can evaluate them without
    /// having to create proper rule-specific context during prediction (as
    /// opposed to the parser, which creates them naturally). In a practical
    /// sense, this avoids a cast exception from RuleContext to myruleContext.
    ///
    /// For context dependent predicates, we must pass in a local context so that
    /// references such as $arg evaluate properly as _localctx.arg. We only
    /// capture context dependent predicates in the context in which we begin
    /// prediction, so we passed in the outer context here in case of context
    /// dependent predicate evaluation.
    ///
    @inlinable
    public func eval<T>(_ parser: Recognizer<T>, _ parserCallStack: RuleContext) throws -> Bool {
        switch self {
        case .none:
            return try parser.sempred(nil, -1, -1)
            
        case let .predicate(ruleIndex, predIndex, isCtxDependent):
            let localctx = isCtxDependent ? parserCallStack : nil
            return try parser.sempred(localctx, ruleIndex, predIndex)
            
        case .precedence(let precedence):
            return parser.precpred(parserCallStack, precedence)
            
        case .operatorAnd(let opnds):
            for opnd in opnds {
                if try !opnd.eval(parser, parserCallStack) {
                    return false
                }
            }
            return true
            
        case .operatorOr(let opnds):
            for opnd in opnds {
                if try opnd.eval(parser, parserCallStack) {
                    return true
                }
            }
            return false
        }
    }
    
    ///
    /// Evaluate the precedence predicates for the context and reduce the result.
    ///
    /// - parameter parser: The parser instance.
    /// - parameter parserCallStack:
    /// - returns: The simplified semantic context after precedence predicates are
    /// evaluated, which will be one of the following values.
    /// * _#NONE_: if the predicate simplifies to `true` after
    /// precedence predicates are evaluated.
    /// * `null`: if the predicate simplifies to `false` after
    /// precedence predicates are evaluated.
    /// * `this`: if the semantic context is not changed as a result of
    /// precedence predicate evaluation.
    /// * A non-`null` _org.antlr.v4.runtime.atn.SemanticContext_: the new simplified
    /// semantic context after precedence predicates are evaluated.
    ///
    @inlinable
    public func evalPrecedence<T>(_ parser: Recognizer<T>, _ parserCallStack: RuleContext) throws -> SemanticContext? {
        switch self {
        case .none, .predicate:
            return self
            
        case .precedence(let precedence):
            if parser.precpred(parserCallStack, precedence) {
                return SemanticContext.none
            } else {
                return nil
            }
            
        case .operatorAnd(let opnds):
            var differs = false
            var operands = [SemanticContext]()
            for context in opnds {
                let evaluated = try context.evalPrecedence(parser, parserCallStack)
                //TODO differs |= (evaluated != context)
                //differs |= (evaluated != context);
                differs = differs || (evaluated != context)
                
                if let evaluated = evaluated {
                    // Reduce the result by skipping true elements
                    if evaluated != SemanticContext.none {
                        operands.append(evaluated)
                    }
                } else if evaluated != SemanticContext.none {
                    // The AND context is false if any element is false
                    return nil
                }
            }
            
            if !differs {
                return self
            }
            
            if operands.isEmpty {
                // all elements were true, so the AND context is true
                return SemanticContext.none
            }
            
            var result = operands[0]
            let length = operands.count
            for i in 1..<length {
                result = .and(result, operands[i])
            }
            
            return result
            
        case .operatorOr(let opnds):
            
            var differs = false
            var operands = [SemanticContext]()
            for context in opnds {
                let evaluated = try context.evalPrecedence(parser, parserCallStack)
                differs = differs || (evaluated != context)
                if evaluated == SemanticContext.none {
                    // The OR context is true if any element is true
                    return SemanticContext.none
                } else if let evaluated = evaluated {
                    // Reduce the result by skipping false elements
                    operands.append(evaluated)
                }
            }
            
            if !differs {
                return self
            }
            
            if operands.isEmpty {
                // all elements were false, so the OR context is false
                return nil
            }
            
            var result = operands[0]
            let length = operands.count
            for i in 1..<length {
                result = .or(result, operands[i])
            }
            
            return result
        }
    }
    
    @inlinable
    public static func and(_ a: SemanticContext?, _ b: SemanticContext?) -> SemanticContext {
        guard let a = a, a != .none else {
            return b!
        }
        guard let b = b, b != .none else {
            return a
        }
        
        let result = AND(a, b)
        switch result {
        case .operatorAnd(let opnds) where opnds.count == 1:
            return opnds[0]
        default:
            return result
        }
    }
    
    ///
    ///
    /// - seealso: org.antlr.v4.runtime.atn.ParserATNSimulator#getPredsForAmbigAlts
    ///
    @inlinable
    public static func or(_ a: SemanticContext?, _ b: SemanticContext?) -> SemanticContext {
        guard let a = a else {
            return b!
        }
        guard let b = b else {
            return a
        }
        if a == .none || b == .none {
            return .none
        }
        
        let result = OR(a, b)
        switch result {
        case .operatorOr(let opnds) where opnds.count == 1:
            return opnds[0]
        default:
            return result
        }
    }
    
    @usableFromInline
    internal static func AND(_ a: SemanticContext, _ b: SemanticContext) -> SemanticContext {
        var operands = Set<SemanticContext>()
        switch a {
        case .operatorAnd(let opnds):
            operands.formUnion(opnds)
        default:
            operands.insert(a)
        }
        
        switch b {
        case .operatorAnd(let opnds):
            operands.formUnion(opnds)
        default:
            operands.insert(b)
        }
        
        let precedencePredicates = SemanticContext.filterPrecedencePredicates(&operands)
        if !precedencePredicates.isEmpty {
            // interested in the transition with the lowest precedence
            
            let reduced = precedencePredicates.sorted {
                $0.precedence < $1.precedence
            }
            operands.insert(reduced[0].1)
        }
        
        return .operatorAnd(Array(operands))
    }
    
    @usableFromInline
    internal static func OR(_ a: SemanticContext, _ b: SemanticContext) -> SemanticContext {
        var operands: Set<SemanticContext> = Set<SemanticContext>()
        switch a {
        case .operatorOr(let opnds):
            operands.formUnion(opnds)
        default:
            operands.insert(a)
        }
        
        switch b {
        case .operatorOr(let opnds):
            operands.formUnion(opnds)
        default:
            operands.insert(b)
        }
        
        let precedencePredicates = SemanticContext.filterPrecedencePredicates(&operands)
        if !precedencePredicates.isEmpty {
            // interested in the transition with the highest precedence
            
            let reduced = precedencePredicates.sorted {
                $0.precedence > $1.precedence
            }
            operands.insert(reduced[0].1)
        }
        
        return .operatorOr(Array(operands))
    }
    
    @usableFromInline
    internal static func filterPrecedencePredicates(_ collection: inout Set<SemanticContext>) -> [(precedence: Int, SemanticContext)] {
        let result: [(Int, SemanticContext)] = collection.compactMap {
            if case .precedence(let prec) = $0 {
                return (prec, $0)
            } else {
                return nil
            }
        }
        collection = Set<SemanticContext>(collection.filter {
            if case .precedence = $0 {
                return false
            } else {
                return true
            }
        })
        return result
    }
}
