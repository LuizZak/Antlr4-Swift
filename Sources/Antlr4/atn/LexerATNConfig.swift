///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

class LexerATNConfigPool: Pooler<LexerATNConfig> {
    
    public func pull(_ state: ATNState,
                     _ alt: Int,
                     _ context: PredictionContext) -> LexerATNConfig {
        
        var value = pull {
            return LexerATNConfig()
        }
        
        value = ParserATNConfigPool.config(value: value, state, alt, context)
        
        value.passedThroughNonGreedyDecision = false
        value.lexerActionExecutor = nil
        
        return value
    }
    
    public func pull(_ state: ATNState,
                     _ alt: Int,
                     _ context: PredictionContext,
                     _ lexerActionExecutor: LexerActionExecutor?) -> LexerATNConfig {
        
        var value = pull {
            return LexerATNConfig()
        }
        
        value = ParserATNConfigPool.config(value: value, state, alt, context, SemanticContext.none)
        
        value.lexerActionExecutor = lexerActionExecutor
        value.passedThroughNonGreedyDecision = false
        
        return value
    }
    
    public func pull(_ c: LexerATNConfig, _ state: ATNState) -> LexerATNConfig {
        
        var value = pull {
            LexerATNConfig()
        }
        
        value = ParserATNConfigPool.config(value: value, c, state, c.context, c.semanticContext)
        
        value.lexerActionExecutor = c.lexerActionExecutor
        value.passedThroughNonGreedyDecision = LexerATNConfig.checkNonGreedyDecision(c, state)
        
        return value
    }
    
    public func pull(_ c: LexerATNConfig,
                     _ state: ATNState,
                     _ lexerActionExecutor: LexerActionExecutor?) -> LexerATNConfig {
        
        var value = pull {
            return LexerATNConfig()
        }
        
        value = ParserATNConfigPool.config(value: value, c, state, c.context, c.semanticContext)
        
        value.lexerActionExecutor = lexerActionExecutor
        value.passedThroughNonGreedyDecision = LexerATNConfig.checkNonGreedyDecision(c, state)
        
        return value
    }
    
    public func pull(_ c: LexerATNConfig,
                     _ state: ATNState,
                     _ context: PredictionContext) -> LexerATNConfig {
        
        var value = pull {
            return LexerATNConfig()
        }
        
        value = ParserATNConfigPool.config(value: value, c, state, context, c.semanticContext)
        
        value.lexerActionExecutor = c.lexerActionExecutor
        value.passedThroughNonGreedyDecision = LexerATNConfig.checkNonGreedyDecision(c, state)
        
        return value
    }
    
}

public struct LexerATNConfig: ATNConfig {
    public mutating func reset() {
        context = nil
        state = BasicState()
        alt = 0
        reachesIntoOuterContext = 0
        semanticContext = .none
        lexerActionExecutor = nil
        passedThroughNonGreedyDecision = false
    }
    
    ///
    /// This field stores the bit mask for implementing the
    /// _#isPrecedenceFilterSuppressed_ property as a bit within the
    /// existing _#reachesIntoOuterContext_ field.
    ///
    private let SUPPRESS_PRECEDENCE_FILTER: Int = 0x40000000
    
    public var state: ATNState
    
    public var alt: Int
    
    public var context: PredictionContext?
    
    public var reachesIntoOuterContext: Int = 0
    //=0 intital by janyou
    
    public var semanticContext: SemanticContext
    
    ///
    /// This is the backing field for _#getLexerActionExecutor_.
    ///
    var lexerActionExecutor: LexerActionExecutor?
    
    var passedThroughNonGreedyDecision: Bool
    
    public var description: String {
        //return "MyClass \(string)"
        return toString(nil, true)
    }
    
    internal init() {
        context = nil
        state = BasicState()
        alt = 0
        reachesIntoOuterContext = 0
        semanticContext = .none
        lexerActionExecutor = nil
        passedThroughNonGreedyDecision = false
    }
    
    public func getOuterContextDepth() -> Int {
        return reachesIntoOuterContext & ~SUPPRESS_PRECEDENCE_FILTER
    }
    
    public func isPrecedenceFilterSuppressed() -> Bool {
        return (reachesIntoOuterContext & SUPPRESS_PRECEDENCE_FILTER) != 0
    }
    
    public mutating func setPrecedenceFilterSuppressed(_ value: Bool) {
        if value {
            self.reachesIntoOuterContext |= 0x40000000
        } else {
            self.reachesIntoOuterContext &= ~SUPPRESS_PRECEDENCE_FILTER
        }
    }
    
    public func toString<T>(_ recog: Recognizer<T>?, _ showAlt: Bool) -> String {
        var buf = "(\(state)"
        if showAlt {
            buf += ",\(alt)"
        }
        if let context = context {
            buf += ",[\(context)]"
        }
        if semanticContext != SemanticContext.none {
            buf += ",\(semanticContext)"
        }
        let outerDepth = getOuterContextDepth()
        if outerDepth > 0 {
            buf += ",up=\(outerDepth)"
        }
        buf += ")"
        return buf
    }
    
    ///
    /// Gets the _org.antlr.v4.runtime.atn.LexerActionExecutor_ capable of executing the embedded
    /// action(s) for the current configuration.
    ///
    public func getLexerActionExecutor() -> LexerActionExecutor? {
        return lexerActionExecutor
    }

    public func hasPassedThroughNonGreedyDecision() -> Bool {
        return passedThroughNonGreedyDecision
    }
    
    ///
    /// An ATN configuration is equal to another if both have
    /// the same state, they predict the same alternative, and
    /// syntactic/semantic contexts are the same.
    ///
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(state.stateNumber)
        hasher.combine(alt)
        hasher.combine(context)
        hasher.combine(semanticContext)
        hasher.combine(passedThroughNonGreedyDecision ? 1 : 0)
        hasher.combine(lexerActionExecutor)
    }

    static func checkNonGreedyDecision(_ source: LexerATNConfig, _ target: ATNState) -> Bool {
        return source.passedThroughNonGreedyDecision
            || (target as? DecisionState)?.nonGreedy ?? false
    }
}

//useless
public func == (lhs: LexerATNConfig, rhs: LexerATNConfig) -> Bool {
    
    if lhs.passedThroughNonGreedyDecision != rhs.passedThroughNonGreedyDecision {
        return false
    }

    if lhs.state.stateNumber != rhs.state.stateNumber {
        return false
    }
    if lhs.alt != rhs.alt {
        return false
    }

    if lhs.isPrecedenceFilterSuppressed() != rhs.isPrecedenceFilterSuppressed() {
        return false
    }

    if lhs.getLexerActionExecutor() != rhs.getLexerActionExecutor() {
        return false
    }

    if lhs.context != rhs.context {
        return false
    }

    return lhs.semanticContext == rhs.semanticContext
}
