///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

///
/// An ATN transition between any two ATN states.  Subclasses define
/// atom, set, epsilon, action, predicate, rule transitions.
///
/// This is a one way link.  It emanates from a state (usually via a list of
/// transitions) and has a target state.
///
/// Since we never have to change the ATN transitions once we construct it,
/// we can fix these transitions as specific classes. The DFA transitions
/// on the other hand need to update the labels as it adds transitions to
/// the states. We'll use the term Edge for the DFA to distinguish them from
/// ATN transitions.
///

import Foundation

public enum PredicateTransition {
    case predicate(ruleIndex: Int, predIndex: Int, isCtxDependent: Bool)
    case precedence(precedence: Int)
    
    public func getPredicate() -> SemanticContext {
        switch self {
        case let .predicate(ruleIndex, predIndex, isCtxDependent):
            return .predicate(ruleIndex: ruleIndex,
                              predIndex: predIndex,
                              isCtxDependent: isCtxDependent)
            
        case .precedence(let precedence):
            return .precedence(precedence)
        }
    }
    
    public var description: String {
        switch self {
        case let .predicate(ruleIndex, predIndex, _):
            return "pred_\(ruleIndex):\(predIndex)"
        case .precedence(let precedence):
            return "\(precedence)  >= _p"
        }
    }
}

public enum Transition: CustomStringConvertible {
    case epsilon(ATNState, outermostPrecedenceReturnInside: Int)
    case range(ATNState, from: Int, to: Int)
    case rule(ATNState, ruleIndex: Int, precedence: Int, followState: ATNState)
    case predicate(ATNState, PredicateTransition)
    case atom(ATNState, label: Int)
    case action(ATNState, ruleIndex: Int, actionIndex: Int, isCtxDependent: Bool)
    case set(ATNState, set: IntervalSet)
    case notSet(ATNState, set: IntervalSet)
    case wildcard(ATNState)
    
    public var target: ATNState {
        get {
            switch self {
            case .epsilon(let state, _),
                 .range(let state, _, _),
                 .rule(let state, _, _, _),
                 .predicate(let state, _),
                 .atom(let state, _),
                 .action(let state, _, _, _),
                 .set(let state, _),
                 .notSet(let state, _),
                 .wildcard(let state):
                return state
            }
        }
        set {
            switch self {
            case .epsilon(_, let outermostPrecedenceReturnInside):
                self = .epsilon(newValue,
                                outermostPrecedenceReturnInside: outermostPrecedenceReturnInside)
                
            case let .range(_, from, to):
                self = .range(newValue, from: from, to: to)
                
            case let .rule(_, ruleIndex, precedence, followState):
                self = .rule(newValue,
                             ruleIndex: ruleIndex,
                             precedence: precedence,
                             followState: followState)
                
            case .predicate(_, let pred):
                self = .predicate(newValue, pred)
                
            case .atom(_, let label):
                self = .atom(newValue, label: label)
                
            case let .action(_, ruleIndex, actionIndex, isCtxDependent):
                self = .action(newValue,
                               ruleIndex: ruleIndex,
                               actionIndex: actionIndex,
                               isCtxDependent: isCtxDependent)
                
            case .set(_, let set):
                self = .set(newValue, set: set)
                
            case .notSet(_, let set):
                self = .notSet(newValue, set: set)
                
            case .wildcard:
                self = .wildcard(newValue)
            }
        }
    }
    
    public var description: String {
        switch self {
        case .epsilon:
            return "epsilon"
            
        case let .range(_, from, to):
            return "'\(from)'..'\(to)'"
            
        case .rule:
            return "\(self)"
            
        case .predicate(_, let transition):
            return transition.description
            
        case .atom(_, let label):
            return String(label)
            
        case let .action(_, ruleIndex, actionIndex, _):
            return "action_\(ruleIndex):\(actionIndex)"
            
        case .set(_, let set):
            return set.description
            
        case .notSet(_, let set):
            return "~" + set.description
            
        case .wildcard:
            return "."
        }
    }
    
    public func getSerializationType() -> Int {
        switch self {
        case .epsilon:
            return Transition.EPSILON
        case .range:
            return Transition.RANGE
        case .rule:
            return Transition.RULE
        case .predicate(_, .predicate):
            return Transition.PREDICATE
        case .predicate(_, .precedence):
            return Transition.PRECEDENCE
        case .atom:
            return Transition.ATOM
        case .action:
            return Transition.ACTION
        case .set:
            return Transition.SET
        case .notSet:
            return Transition.NOT_SET
        case .wildcard:
            return Transition.WILDCARD
        }
    }
    
    ///
    /// Determines if the transition is an "epsilon" transition.
    ///
    /// - returns: `true` if traversing this transition in the ATN does not
    /// consume an input symbol; otherwise, `false` if traversing this
    /// transition consumes (matches) an input symbol.
    ///
    public func isEpsilon() -> Bool {
        switch self {
        case .epsilon, .rule, .predicate:
            return true
            
        case .action:
            return true // we are to be ignored by analysis 'cept for predicates
            
        case .range, .atom, .set, .notSet, .wildcard:
            return false
        }
    }
    
    public func labelIntervalSet() -> IntervalSet? {
        switch self {
        case .epsilon, .rule, .predicate, .action, .wildcard:
            return nil
            
        case let .range(_, from, to):
            return .of(from, to)
            
        case .atom(_, let label):
            return IntervalSet(label)
            
        case .set(_, let set), .notSet(_, let set):
            return set
        }
    }
    
    public func matches(_ symbol: Int, _ minVocabSymbol: Int, _ maxVocabSymbol: Int) -> Bool {
        switch self {
        case .epsilon, .rule, .predicate, .action:
            return false
            
        case let .range(_, from, to):
            return symbol >= from && symbol <= to
            
        case .atom(_, let label):
            return label == symbol
            
        case .set(_, let set):
            return set.contains(symbol)
            
        case .notSet(_, let set):
            return symbol >= minVocabSymbol
                && symbol <= maxVocabSymbol
                && !set.contains(symbol)
            
        case .wildcard:
            return symbol >= minVocabSymbol && symbol <= maxVocabSymbol
        }
    }
    
    // constants for serialization
    public static let EPSILON: Int = 1
    public static let RANGE: Int = 2
    public static let RULE: Int = 3
    public static let PREDICATE: Int = 4
    // e.g., {isType(input.LT(1))}?
    public static let ATOM: Int = 5
    public static let ACTION: Int = 6
    public static let SET: Int = 7
    // ~(A|B) or ~atom, wildcard, which convert to next 2
    public static let NOT_SET: Int = 8
    public static let WILDCARD: Int = 9
    public static let PRECEDENCE: Int = 10
}
