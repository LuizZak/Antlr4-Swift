///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

public func RuleTransition(_ ruleStart: RuleStartState,
                           _ ruleIndex: Int,
                           _ followState: ATNState) -> Transition {
    return RuleTransition(ruleStart, ruleIndex, 0, followState)
}

public func RuleTransition(_ ruleStart: RuleStartState,
                           _ ruleIndex: Int,
                           _ precedence: Int,
                           _ followState: ATNState) -> Transition {
    
    return .rule(ruleStart, ruleIndex: ruleIndex, precedence: precedence,
                 followState: followState)
}
