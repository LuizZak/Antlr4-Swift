///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

public class ParserATNConfigPool: Pooler<ParserATNConfig> {
    
    public override init() {
        
    }
    
    @inlinable
    public func pull<T: ATNConfig>(_ old: T) -> ParserATNConfig {
        let value = pull {
            return ParserATNConfig()
        }
        
        return ParserATNConfigPool.config(value: value, old)
    }
    
    @inlinable
    public func pull(_ state: ATNState,
                     _ alt: Int,
                     _ context: PredictionContext?) -> ParserATNConfig {
        
        return pull(state, alt, context, SemanticContext.none)
    }
    
    @inlinable
    public func pull(_ state: ATNState,
                     _ alt: Int,
                     _ context: PredictionContext?,
                     _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        let value = pull {
            return ParserATNConfig()
        }
        
        return ParserATNConfigPool.config(value: value, state, alt, context, semanticContext)
    }
    
    @inlinable
    public func pull<T: ATNConfig>(_ c: T, _ state: ATNState) -> ParserATNConfig {
        return self.pull(c, state, c.context, c.semanticContext)
    }
    
    @inlinable
    public func pull<T: ATNConfig>(_ c: T,
                                   _ state: ATNState,
                                   _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        return self.pull(c, state, c.context, semanticContext)
    }
    
    @inlinable
    public func pull<T: ATNConfig>(_ c: T,
                                   _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        return self.pull(c, c.state, c.context, semanticContext)
    }
    
    @inlinable
    public func pull<T: ATNConfig>(_ c: T,
                                   _ state: ATNState,
                                   _ context: PredictionContext?) -> ParserATNConfig {
        
        return self.pull(c, state, context, c.semanticContext)
    }
    
    @inlinable
    public func pull<T: ATNConfig>(_ c: T,
                                   _ state: ATNState,
                                   _ context: PredictionContext?,
                                   _ semanticContext: SemanticContext) -> ParserATNConfig {
        
        let value = pull {
            return ParserATNConfig()
        }
        
        return ParserATNConfigPool.config(value: value, c, state, context, semanticContext)
    }
    
    @inlinable
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
    
    @inlinable
    public static func config<T: ATNConfig>(value: T,
                                            _ state: ATNState,
                                            _ alt: Int,
                                            _ context: PredictionContext?) -> T {
        
        return config(value: value, state, alt, context, SemanticContext.none)
    }
    
    @inlinable
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
    
    @inlinable
    public static func config<T: ATNConfig, U: ATNConfig>(value: T, _ c: U, _ state: ATNState) -> T {
        return self.config(value: value, c, state, c.context, c.semanticContext)
    }
    
    @inlinable
    public static func config<T: ATNConfig, U: ATNConfig>(value: T,
                                                          _ c: U,
                                                          _ state: ATNState,
                                                          _ semanticContext: SemanticContext) -> T {
        
        return self.config(value: value, c, state, c.context, semanticContext)
    }
    
    @inlinable
    public static func config<T: ATNConfig, U: ATNConfig>(value: T,
                                                          _ c: U,
                                                          _ semanticContext: SemanticContext) -> T {
        
        return self.config(value: value, c, c.state, c.context, semanticContext)
    }
    
    @inlinable
    public static func config<T: ATNConfig, U: ATNConfig>(value: T,
                                                          _ c: U,
                                                          _ state: ATNState,
                                                          _ context: PredictionContext?) -> T {
        
        return self.config(value: value, c, state, context, c.semanticContext)
    }
    
    @inlinable
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
