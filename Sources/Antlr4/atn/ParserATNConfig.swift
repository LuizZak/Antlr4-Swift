///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

public final class ParserATNConfig: ATNConfig, CustomStringConvertible {
    private static let _state = BasicState()
    
    public func reset() {
        context = nil
        state = ParserATNConfig._state
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
    
    private var _cachedHashCode: Int?
    
    public var state: ATNState {
        didSet {
            _cachedHashCode = nil
        }
    }
    
    public var alt: Int {
        didSet {
            _cachedHashCode = nil
        }
    }
    
    public var context: PredictionContext? {
        didSet {
            _cachedHashCode = nil
        }
    }
    
    public var reachesIntoOuterContext: Int = 0
    //=0 intital by janyou

    public var semanticContext: SemanticContext {
        didSet {
            _cachedHashCode = nil
        }
    }
    
    @usableFromInline
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
    
    public var hashValue: Int {
        if let cachedHashCode = _cachedHashCode {
            return cachedHashCode
        }
        
        var hasher = Hasher()
        hasher.combine(state.stateNumber)
        hasher.combine(alt)
        hasher.combine(context)
        hasher.combine(semanticContext)
        let result = hasher.finalize()
        _cachedHashCode = result
        
        return result
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
