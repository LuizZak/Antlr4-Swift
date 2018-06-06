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

public class LexerAction: Hashable {
    ///
    /// Gets the serialization type of the lexer action.
    ///
    /// - returns: The serialization type of the lexer action.
    ///
    public func getActionType() -> LexerActionType {
        fatalError(#function + " must be overridden")
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
        fatalError(#function + " must be overridden")
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
        fatalError(#function + " must be overridden")
    }
    
    public func hash(into hasher: inout Hasher) {
        fatalError(#function + " must be overridden")
    }

}

public func == (lhs: LexerAction, rhs: LexerAction) -> Bool {

    if lhs === rhs {
        return true
    }

    if let lhs = lhs as? LexerChannelAction, let rhs = rhs as? LexerChannelAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerCustomAction, let rhs = rhs as? LexerCustomAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerIndexedCustomAction, let rhs = rhs as? LexerIndexedCustomAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerModeAction, let rhs = rhs as? LexerModeAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerMoreAction, let rhs = rhs as? LexerMoreAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerPopModeAction, let rhs = rhs as? LexerPopModeAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerPushModeAction, let rhs = rhs as? LexerPushModeAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerSkipAction, let rhs = rhs as? LexerSkipAction {
        return lhs == rhs
    } else if let lhs = lhs as? LexerTypeAction, let rhs = rhs as? LexerTypeAction {
        return lhs == rhs
    }

    return false

}
