///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

///
/// Represents a single action which can be executed following the successful
/// match of a lexer rule. Lexer actions are used for both embedded action syntax
/// and ANTLR 4's new lexer command syntax.
///
/// -  Sam Harwell
/// -  4.2
///

public enum LexerAction: Hashable {
    
    case channel(Int)
    case customRule(ruleIndex: Int, actionIndex: Int)
    indirect case indexedCustomAction(offset: Int, action: LexerAction)
    case mode(Int)
    case more
    case popMode
    case pushMode(mode: Int)
    case skip
    case type(Int)
    
    ///
    /// Gets the serialization type of the lexer action.
    ///
    /// - returns: The serialization type of the lexer action.
    ///
    public func getActionType() -> LexerActionType {
        switch self {
        case .channel:
            return .channel
            
        case .customRule:
            return .custom
            
        case .indexedCustomAction(_, let action):
            return action.getActionType()
            
        case .mode:
            return .mode
            
        case .more:
            return .more
            
        case .popMode:
            return .popMode
            
        case .pushMode:
            return .pushMode
            
        case .skip:
            return .skip
            
        case .type:
            return .type
        }
    }
    
    ///
    /// Gets whether the lexer action is position-dependent. Position-dependent
    /// actions may have different semantics depending on the _org.antlr.v4.runtime.CharStream_
    /// index at the time the action is executed.
    ///
    /// Many lexer commands, including `type`, `skip`, and
    /// `more`, do not check the input index during their execution.
    /// Actions like this are position-independent, and may be stored more
    /// efficiently as part of the _org.antlr.v4.runtime.atn.LexerATNConfig#lexerActionExecutor_.
    ///
    /// - returns: `true` if the lexer action semantics can be affected by the
    /// position of the input _org.antlr.v4.runtime.CharStream_ at the time it is executed;
    /// otherwise, `false`.
    ///
    public func isPositionDependent() -> Bool {
        switch self {
        case .channel, .mode, .more, .popMode, .pushMode, .skip, .type:
            return false
            
        case .customRule:
            return true
            
        case .indexedCustomAction:
            return true
        }
    }
    
    ///
    /// Execute the lexer action in the context of the specified _org.antlr.v4.runtime.Lexer_.
    ///
    /// For position-dependent actions, the input stream must already be
    /// positioned correctly prior to calling this method.
    ///
    /// - parameter lexer: The lexer instance.
    ///
    public func execute(_ lexer: Lexer) throws {
        switch self {
        case .channel(let channel):
            lexer.setChannel(channel)
            
        case .customRule(let ruleIndex, let actionIndex):
            try lexer.action(nil, ruleIndex, actionIndex)
            
        case .indexedCustomAction(_, let action):
            // assume the input stream position was properly set by the calling code
            try action.execute(lexer)
            
        case .mode(let mode):
            lexer.mode(mode)
            
        case .more:
            lexer.more()
            
        case .popMode:
            try lexer.popMode()
            
        case .pushMode(let mode):
            lexer.pushMode(mode)
            
        case .skip:
            lexer.skip()
            
        case .type(let type):
            lexer.setType(type)
        }
    }
}
