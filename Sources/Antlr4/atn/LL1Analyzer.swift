///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

public struct LL1Analyzer {
    var atnConfigPool: ParserATNConfigPool
    
    ///
    /// Special value added to the lookahead sets to indicate that we hit
    /// a predicate during analysis if `seeThruPreds==false`.
    ///
    public let HIT_PRED: Int = CommonToken.invalidType

    public let atn: ATN

    public init(atnConfigPool: ParserATNConfigPool, _ atn: ATN) {
        self.atnConfigPool = atnConfigPool
        self.atn = atn
    }

    ///
    /// Calculates the SLL(1) expected lookahead set for each outgoing transition
    /// of an _org.antlr.v4.runtime.atn.ATNState_. The returned array has one element for each
    /// outgoing transition in `s`. If the closure from transition
    /// __i__ leads to a semantic predicate before matching a symbol, the
    /// element at index __i__ of the result will be `null`.
    ///
    /// - parameter s: the ATN state
    /// - returns: the expected symbols for each outgoing transition of `s`.
    ///
    public func getDecisionLookahead(_ s: ATNState?) -> [IntervalSet?]? {

        guard let s = s else {
            return nil
        }
        let length = s.getNumberOfTransitions()
        var look = [IntervalSet?](repeating: nil, count: length)
        for alt in 0..<length {
            look[alt] = IntervalSet()
            var lookBusy = Set<ParserATNConfig>()
            let seeThruPreds = false // fail to get lookahead upon pred
            var bitSet = BitSet()
            _LOOK(s.transition(alt).target, nil, PredictionContext.EMPTY,
                  &look[alt]!, &lookBusy, &bitSet, seeThruPreds, false)
            // Wipe out lookahead for this alternative if we found nothing
            // or we had a predicate when we !seeThruPreds
            if look[alt]!.size() == 0 || look[alt]!.contains(HIT_PRED) {
                look[alt] = nil
            }
        }
        return look
    }

    ///
    /// Compute set of tokens that can follow `s` in the ATN in the
    /// specified `ctx`.
    ///
    /// If `ctx` is `null` and the end of the rule containing
    /// `s` is reached, _org.antlr.v4.runtime.Token#EPSILON_ is added to the result set.
    /// If `ctx` is not `null` and the end of the outermost rule is
    /// reached, _org.antlr.v4.runtime.Token#EOF_ is added to the result set.
    ///
    /// - parameter s: the ATN state
    /// - parameter ctx: the complete parser context, or `null` if the context
    /// should be ignored
    ///
    /// - returns: The set of tokens that can follow `s` in the ATN in the
    /// specified `ctx`.
    ///
    public func LOOK(_ s: ATNState, _ ctx: RuleContext?) -> IntervalSet {
        return LOOK(s, nil, ctx)
    }

    ///
    /// Compute set of tokens that can follow `s` in the ATN in the
    /// specified `ctx`.
    ///
    /// If `ctx` is `null` and the end of the rule containing
    /// `s` is reached, _org.antlr.v4.runtime.Token#EPSILON_ is added to the result set.
    /// If `ctx` is not `null` and the end of the outermost rule is
    /// reached, _org.antlr.v4.runtime.Token#EOF_ is added to the result set.
    ///
    /// - parameter s: the ATN state
    /// - parameter stopState: the ATN state to stop at. This can be a
    /// _org.antlr.v4.runtime.atn.BlockEndState_ to detect epsilon paths through a closure.
    /// - parameter ctx: the complete parser context, or `null` if the context
    /// should be ignored
    ///
    /// - returns: The set of tokens that can follow `s` in the ATN in the
    /// specified `ctx`.
    ///

    public func LOOK(_ s: ATNState, _ stopState: ATNState?, _ ctx: RuleContext?) -> IntervalSet {
        var r = IntervalSet()
        let seeThruPreds = true // ignore preds; get all lookahead
        let lookContext = ctx != nil ? PredictionContext.fromRuleContext(s.atn!, ctx) : nil
        var config = Set<ParserATNConfig>()
        var bitSet = BitSet()
        _LOOK(s, stopState, lookContext, &r, &config, &bitSet, seeThruPreds, true)
        atnConfigPool.repool(from: &config)
        return r
    }

    ///
    /// Compute set of tokens that can follow `s` in the ATN in the
    /// specified `ctx`.
    ///
    /// If `ctx` is `null` and `stopState` or the end of the
    /// rule containing `s` is reached, _org.antlr.v4.runtime.Token#EPSILON_ is added to
    /// the result set. If `ctx` is not `null` and `addEOF` is
    /// `true` and `stopState` or the end of the outermost rule is
    /// reached, _org.antlr.v4.runtime.Token#EOF_ is added to the result set.
    ///
    /// - parameter s: the ATN state.
    /// - parameter stopState: the ATN state to stop at. This can be a
    /// _org.antlr.v4.runtime.atn.BlockEndState_ to detect epsilon paths through a closure.
    /// - parameter ctx: The outer context, or `null` if the outer context should
    /// not be used.
    /// - parameter look: The result lookahead set.
    /// - parameter lookBusy: A set used for preventing epsilon closures in the ATN
    /// from causing a stack overflow. Outside code should pass
    /// `new HashSet<ATNConfig>` for this argument.
    /// - parameter calledRuleStack: A set used for preventing left recursion in the
    /// ATN from causing a stack overflow. Outside code should pass
    /// `new BitSet()` for this argument.
    /// - parameter seeThruPreds: `true` to true semantic predicates as
    /// implicitly `true` and "see through them", otherwise `false`
    /// to treat semantic predicates as opaque and add _#HIT_PRED_ to the
    /// result if one is encountered.
    /// - parameter addEOF: Add _org.antlr.v4.runtime.Token#EOF_ to the result if the end of the
    /// outermost context is reached. This parameter has no effect if `ctx`
    /// is `null`.
    ///
    internal func _LOOK(_ s: ATNState,
                        _ stopState: ATNState?,
                        _ ctx: PredictionContext?,
                        _ look: inout IntervalSet,
                        _ lookBusy: inout Set<ParserATNConfig>,
                        _ calledRuleStack: inout BitSet,
                        _ seeThruPreds: Bool,
                        _ addEOF: Bool) {
        // print ("_LOOK(\(s.stateNumber), ctx=\(ctx)");
        let c = atnConfigPool.pull(s, 0, ctx)
        if lookBusy.contains(c) {
            return
        } else {
            lookBusy.insert(c)
        }

        if s == stopState {
            guard let ctx = ctx else {
                look.add(CommonToken.epsilon)
                return
            }

            if ctx.isEmpty() && addEOF {
                look.add(CommonToken.EOF)
                return
            }

        }

        if s is RuleStopState {
            guard let ctx = ctx else {
                look.add(CommonToken.epsilon)
                return
            }

            if ctx.isEmpty() && addEOF {
                look.add(CommonToken.EOF)
                return
            }

            if ctx != PredictionContext.EMPTY {
                // run thru all possible stack tops in ctx
                let length = ctx.size()
                for i in 0..<length {
                    let returnState = atn.states[(ctx.getReturnState(i))]!
                    let removed = calledRuleStack.get(returnState.ruleIndex!)
                    calledRuleStack.clear(returnState.ruleIndex!)
                    _LOOK(returnState, stopState, ctx.getParent(i),
                          &look, &lookBusy, &calledRuleStack, seeThruPreds, addEOF)
                    if removed {
                        calledRuleStack.set(returnState.ruleIndex!)
                    }
                }
                return
            }
        }

        let n = s.getNumberOfTransitions()
        for i in 0..<n {
            let t = s.transition(i)
            
            switch t {
            case let .rule(target, _, _, followState):
                if calledRuleStack.get(target.ruleIndex!) {
                    continue
                }
                
                let newContext = SingletonPredictionContext.create(ctx, followState.stateNumber)
                calledRuleStack.set(target.ruleIndex!)
                _LOOK(t.target, stopState, newContext, &look, &lookBusy, &calledRuleStack, seeThruPreds, addEOF)
                calledRuleStack.clear(target.ruleIndex!)
            case .predicate:
                if seeThruPreds {
                    _LOOK(t.target, stopState, ctx, &look, &lookBusy, &calledRuleStack, seeThruPreds, addEOF)
                } else {
                    look.add(HIT_PRED)
                }
            default:
                if t.isEpsilon() {
                    _LOOK(t.target, stopState, ctx, &look, &lookBusy, &calledRuleStack, seeThruPreds, addEOF)
                } else if case .wildcard = t {
                    look.addAll(IntervalSet.of(CommonToken.minUserTokenType, atn.maxTokenType))
                } else {
                    var set = t.labelIntervalSet()
                    if let _set = set {
                        if case .notSet = t {
                            set =
                                _set.complement(IntervalSet.of(CommonToken.minUserTokenType, atn.maxTokenType))
                                as? IntervalSet
                        }
                        look.addAll(set)
                    }
                }
            }
        }
    }
}
