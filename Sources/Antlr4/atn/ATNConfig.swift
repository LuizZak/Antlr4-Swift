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
