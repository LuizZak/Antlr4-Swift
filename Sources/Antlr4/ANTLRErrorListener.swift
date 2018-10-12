///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
/// How to emit recognition errors.
///

public protocol ANTLRErrorListener: class {
    ///
    /// Upon syntax error, notify any interested parties. This is not how to
    /// recover from errors or compute error messages. _org.antlr.v4.runtime.ANTLRErrorStrategy_
    /// specifies how to recover from syntax errors and how to compute error
    /// messages. This listener's job is simply to emit a computed message,
    /// though it has enough information to create its own message in many cases.
    ///
    /// The _RecognitionException_ is non-null for all syntax errors except
    /// when we discover mismatched token errors that we can recover from
    /// in-line, without returning from the surrounding rule (via the single
    /// token insertion and deletion mechanism).
    ///
    /// - parameter recognizer:
    /// What parser got the error. From this
    /// object, you can access the context as well
    /// as the input stream.
    /// - parameter offendingSymbol:
    /// The offending token in the input token
    /// stream, unless recognizer is a lexer (then it's null). If
    /// no viable alternative error, `e` has token at which we
    /// started production for the decision.
    /// - parameter line:
    /// The line number in the input where the error occurred.
    /// - parameter charPositionInLine:
    /// The character position within that line where the error occurred.
    /// - parameter msg:
    /// The message to emit.
    /// - parameter e:
    /// The exception generated by the parser that led to
    /// the reporting of an error. It is null in the case where
    /// the parser was able to recover in line without exiting the
    /// surrounding rule.
    ///
    func syntaxError<T>(_ recognizer: Recognizer<T>,
                        _ offendingSymbol: AnyObject?,
                        _ line: Int,
                        _ charPositionInLine: Int,
                        _ msg: String,
                        _ e: AnyObject?
    )

    ///
    /// This method is called by the parser when a full-context prediction
    /// results in an ambiguity.
    ///
    /// Each full-context prediction which does not result in a syntax error
    /// will call either _#reportContextSensitivity_ or
    /// _#reportAmbiguity_.
    ///
    /// When `ambigAlts` is not null, it contains the set of potentially
    /// viable alternatives identified by the prediction algorithm. When
    /// `ambigAlts` is null, use _org.antlr.v4.runtime.atn.ATNConfigSet#getAlts_ to obtain the
    /// represented alternatives from the `configs` argument.
    ///
    /// When `exact` is `true`, __all__ of the potentially
    /// viable alternatives are truly viable, i.e. this is reporting an exact
    /// ambiguity. When `exact` is `false`, __at least two__ of
    /// the potentially viable alternatives are viable for the current input, but
    /// the prediction algorithm terminated as soon as it determined that at
    /// least the __minimum__ potentially viable alternative is truly
    /// viable.
    ///
    /// When the _org.antlr.v4.runtime.atn.PredictionMode#LL_EXACT_AMBIG_DETECTION_ prediction
    /// mode is used, the parser is required to identify exact ambiguities so
    /// `exact` will always be `true`.
    ///
    /// This method is not used by lexers.
    ///
    /// - parameter recognizer: the parser instance
    /// - parameter dfa: the DFA for the current decision
    /// - parameter startIndex: the input index where the decision started
    /// - parameter stopIndex: the input input where the ambiguity was identified
    /// - parameter exact: `true` if the ambiguity is exactly known, otherwise
    /// `false`. This is always `true` when
    /// _org.antlr.v4.runtime.atn.PredictionMode#LL_EXACT_AMBIG_DETECTION_ is used.
    /// - parameter ambigAlts: the potentially ambiguous alternatives, or `null`
    /// to indicate that the potentially ambiguous alternatives are the complete
    /// set of represented alternatives in `configs`
    /// - parameter configs: the ATN configuration set where the ambiguity was
    /// identified
    ///
    func reportAmbiguity(_ recognizer: Parser,
                         _ dfa: DFA<ParserATNConfig>,
                         _ startIndex: Int,
                         _ stopIndex: Int,
                         _ exact: Bool,
                         _ ambigAlts: BitSet,
                         _ configs: ATNConfigSet<ParserATNConfig>)

    ///
    /// This method is called when an SLL conflict occurs and the parser is about
    /// to use the full context information to make an LL decision.
    ///
    /// If one or more configurations in `configs` contains a semantic
    /// predicate, the predicates are evaluated before this method is called. The
    /// subset of alternatives which are still viable after predicates are
    /// evaluated is reported in `conflictingAlts`.
    ///
    /// This method is not used by lexers.
    ///
    /// - parameter recognizer: the parser instance
    /// - parameter dfa: the DFA for the current decision
    /// - parameter startIndex: the input index where the decision started
    /// - parameter stopIndex: the input index where the SLL conflict occurred
    /// - parameter conflictingAlts: The specific conflicting alternatives. If this is
    /// `null`, the conflicting alternatives are all alternatives
    /// represented in `configs`. At the moment, conflictingAlts is non-null
    /// (for the reference implementation, but Sam's optimized version can see this
    /// as null).
    /// - parameter configs: the ATN configuration set where the SLL conflict was
    /// detected
    ///
    func reportAttemptingFullContext(_ recognizer: Parser,
                                     _ dfa: DFA<ParserATNConfig>,
                                     _ startIndex: Int,
                                     _ stopIndex: Int,
                                     _ conflictingAlts: BitSet?,
                                     _ configs: ATNConfigSet<ParserATNConfig>)

    ///
    /// This method is called by the parser when a full-context prediction has a
    /// unique result.
    ///
    /// Each full-context prediction which does not result in a syntax error
    /// will call either _#reportContextSensitivity_ or
    /// _#reportAmbiguity_.
    ///
    /// For prediction implementations that only evaluate full-context
    /// predictions when an SLL conflict is found (including the default
    /// _org.antlr.v4.runtime.atn.ParserATNSimulator_ implementation), this method reports cases
    /// where SLL conflicts were resolved to unique full-context predictions,
    /// i.e. the decision was context-sensitive. This report does not necessarily
    /// indicate a problem, and it may appear even in completely unambiguous
    /// grammars.
    ///
    /// `configs` may have more than one represented alternative if the
    /// full-context prediction algorithm does not evaluate predicates before
    /// beginning the full-context prediction. In all cases, the final prediction
    /// is passed as the `prediction` argument.
    ///
    /// Note that the definition of "context sensitivity" in this method
    /// differs from the concept in _org.antlr.v4.runtime.atn.DecisionInfo#contextSensitivities_.
    /// This method reports all instances where an SLL conflict occurred but LL
    /// parsing produced a unique result, whether or not that unique result
    /// matches the minimum alternative in the SLL conflicting set.
    ///
    /// This method is not used by lexers.
    ///
    /// - parameter recognizer: the parser instance
    /// - parameter dfa: the DFA for the current decision
    /// - parameter startIndex: the input index where the decision started
    /// - parameter stopIndex: the input index where the context sensitivity was
    /// finally determined
    /// - parameter prediction: the unambiguous result of the full-context prediction
    /// - parameter configs: the ATN configuration set where the unambiguous prediction
    /// was determined
    ///
    func reportContextSensitivity(_ recognizer: Parser,
                                  _ dfa: DFA<ParserATNConfig>,
                                  _ startIndex: Int,
                                  _ stopIndex: Int,
                                  _ prediction: Int,
                                  _ configs: ATNConfigSet<ParserATNConfig>)
}
