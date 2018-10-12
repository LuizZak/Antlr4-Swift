///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

///
/// A tuple: (ATN state, predicted alt, syntactic, semantic context).
/// The syntactic context is a graph-structured stack node whose
/// path(s) to the root is the rule invocation(s)
/// chain used to arrive at the state.  The semantic context is
/// the tree of semantic predicates encountered before reaching
/// an ATN state.
///

public class ParserATNConfigPool: Pooler<ParserATNConfig> {
    
    public func pull<T: ATNConfig>(_ old: T) -> ParserATNConfig {
        let value = pull {
            return ParserATNConfig()
        }
        
        return ParserATNConfigPool.config(value: value, old)
    }
    
    public func pull(_ state: ATNState,
                     _ alt: Int,
                     _ context: PredictionContext?) -> ParserATNConfig {
        
        return pull(state, alt, context, SemanticContext.none)
    }
    
    public func pull(_ state: ATNState,
                     _ alt: Int,
                     _ context: PredictionContext?,
                     _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        let value = pull {
            return ParserATNConfig()
        }
        
        return ParserATNConfigPool.config(value: value, state, alt, context, semanticContext)
    }
    
    public func pull<T: ATNConfig>(_ c: T, _ state: ATNState) -> ParserATNConfig {
        return self.pull(c, state, c.context, c.semanticContext)
    }
    
    public func pull<T: ATNConfig>(_ c: T,
                                    _ state: ATNState,
                                    _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        return self.pull(c, state, c.context, semanticContext)
    }
    
    public func pull<T: ATNConfig>(_ c: T,
                                    _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        return self.pull(c, c.state, c.context, semanticContext)
    }
    
    public func pull<T: ATNConfig>(_ c: T,
                                    _ state: ATNState,
                                    _ context: PredictionContext?) -> ParserATNConfig {
        
        return self.pull(c, state, context, c.semanticContext)
    }
    
    public func pull<T: ATNConfig>(_ c: T,
                                    _ state: ATNState,
                                    _ context: PredictionContext?,
                                    _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        let value = pull {
            return ParserATNConfig()
        }
        
        return ParserATNConfigPool.config(value: value, c, state, context, semanticContext)
    }
    
    public static func config<T: ATNConfig, U: ATNConfig>(value: T, _ old: U) -> T {
        var value = value
        
        // dup
        value.state = old.state
        value.alt = old.alt
        value.context = old.context
        value.semanticContext = old.semanticContext
        value.reachesIntoOuterContext = old.reachesIntoOuterContext
        
        return value
    }
    
    public static func config<T: ATNConfig>(value: T,
                                             _ state: ATNState,
                                             _ alt: Int,
                                             _ context: PredictionContext?) -> T {
        
        return config(value: value, state, alt, context, SemanticContext.none)
    }
    
    public static func config<T: ATNConfig>(value: T,
                                             _ state: ATNState,
                                             _ alt: Int,
                                             _ context: PredictionContext?,
                                             _ semanticContext: SemanticContext) -> T {
        
        var value = value
        
        value.state = state
        value.alt = alt
        value.context = context
        value.semanticContext = semanticContext
        
        return value
    }
    
    public static func config<T: ATNConfig, U: ATNConfig>(value: T, _ c: U, _ state: ATNState) -> T {
        return self.config(value: value, c, state, c.context, c.semanticContext)
    }
    
    public static func config<T: ATNConfig, U: ATNConfig>(value: T,
                                                            _ c: U,
                                                            _ state: ATNState,
                                                            _ semanticContext: SemanticContext) -> T {
        
        return self.config(value: value, c, state, c.context, semanticContext)
    }
    
    public static func config<T: ATNConfig, U: ATNConfig>(value: T,
                                                            _ c: U,
                                                            _ semanticContext: SemanticContext) -> T {
        
        return self.config(value: value, c, c.state, c.context, semanticContext)
    }
    
    public static func config<T: ATNConfig, U: ATNConfig>(value: T,
                                                            _ c: U,
                                                            _ state: ATNState,
                                                            _ context: PredictionContext?) -> T {
        
        return self.config(value: value, c, state, context, c.semanticContext)
    }
    
    public static func config<T: ATNConfig, U: ATNConfig>(value: T,
                                                            _ c: U,
                                                            _ state: ATNState,
                                                            _ context: PredictionContext?,
                                                            _ semanticContext: SemanticContext) -> T {
        
        var value = value
        
        value.state = state
        value.alt = c.alt
        value.context = context
        value.semanticContext = semanticContext
        value.reachesIntoOuterContext = c.reachesIntoOuterContext
        
        return value
    }
    
}

public protocol ATNConfig: Poolable, Hashable, CustomStringConvertible {
    
    ///
    /// The ATN state associated with this configuration
    ///
    var state: ATNState { get set }
    
    ///
    /// What alt (or lexer rule) is predicted by this configuration
    ///
    var alt: Int  { get set }
    
    ///
    /// The stack of invoking states leading to the rule/states associated
    /// with this config.  We track only those contexts pushed during
    /// execution of the ATN simulator.
    ///
    var context: PredictionContext?  { get set }
    
    ///
    /// We cannot execute predicates dependent upon local context unless
    /// we know for sure we are in the correct context. Because there is
    /// no way to do this efficiently, we simply cannot evaluate
    /// dependent predicates unless we are in the rule that initially
    /// invokes the ATN simulator.
    ///
    ///
    /// closure() tracks the depth of how far we dip into the outer context:
    /// depth &gt; 0.  Note that it may not be totally accurate depth since I
    /// don't ever decrement. TODO: make it a boolean then
    ///
    ///
    /// For memory efficiency, the _#isPrecedenceFilterSuppressed_ method
    /// is also backed by this field. Since the field is publicly accessible, the
    /// highest bit which would not cause the value to become negative is used to
    /// store this field. This choice minimizes the risk that code which only
    /// compares this value to 0 would be affected by the new purpose of the
    /// flag. It also ensures the performance of the existing _org.antlr.v4.runtime.atn.ATNConfig_
    /// constructors as well as certain operations like
    /// _org.antlr.v4.runtime.atn.ATNConfigSet#add(org.antlr.v4.runtime.atn.ATNConfig, DoubleKeyMap)_ method are
    /// __completely__ unaffected by the change.
    ///
    var reachesIntoOuterContext: Int { get set }
    
    var semanticContext: SemanticContext { get set }
    
    ///
    /// This method gets the value of the _#reachesIntoOuterContext_ field
    /// as it existed prior to the introduction of the
    /// _#isPrecedenceFilterSuppressed_ method.
    ///
    func getOuterContextDepth() -> Int
    
    func isPrecedenceFilterSuppressed() -> Bool
    mutating func setPrecedenceFilterSuppressed(_ value: Bool)
    
    func toString<T>(_ recog: Recognizer<T>?, _ showAlt: Bool) -> String

}

public class ParserATNConfig: Poolable, ATNConfig, Hashable, CustomStringConvertible {
    public func reset() {
        context = nil
        state = BasicState()
        alt = 0
        reachesIntoOuterContext = 0
        semanticContext = .none
    }
    
    ///
    /// This field stores the bit mask for implementing the
    /// _#isPrecedenceFilterSuppressed_ property as a bit within the
    /// existing _#reachesIntoOuterContext_ field.
    ///
    private final let SUPPRESS_PRECEDENCE_FILTER: Int = 0x40000000
    
    public final var state: ATNState
    
    public final var alt: Int
    
    public final var context: PredictionContext?
    
    public final var reachesIntoOuterContext: Int = 0
    //=0 intital by janyou

    public final var semanticContext: SemanticContext

    internal init() {
        context = nil
        state = BasicState()
        alt = 0
        reachesIntoOuterContext = 0
        semanticContext = .none
    }
    
    public final func getOuterContextDepth() -> Int {
        return reachesIntoOuterContext & ~SUPPRESS_PRECEDENCE_FILTER
    }

    public final func isPrecedenceFilterSuppressed() -> Bool {
        return (reachesIntoOuterContext & SUPPRESS_PRECEDENCE_FILTER) != 0
    }

    public final func setPrecedenceFilterSuppressed(_ value: Bool) {
        if value {
            self.reachesIntoOuterContext |= 0x40000000
        } else {
            self.reachesIntoOuterContext &= ~SUPPRESS_PRECEDENCE_FILTER
        }
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
    }
    
    public var description: String {
        //return "MyClass \(string)"
        return toString(nil, true)
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
}

public func == (lhs: ParserATNConfig, rhs: ParserATNConfig) -> Bool {

    if lhs === rhs {
        return true
    }

    if lhs.state.stateNumber != rhs.state.stateNumber {
        return false
    }
    if lhs.alt != rhs.alt {
        return false
    }
    
    if lhs.context != rhs.context {
        return false
    }

    return lhs.semanticContext == rhs.semanticContext
}
