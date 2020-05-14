// Generated from /Users/luizsilva/Documents/Local Projects/antlr4-swift/Tests/Antlr4Tests/LexerA.g4 by ANTLR 4.7
import Antlr4

open class LexerA: Lexer {
	internal static var _decisionToDFA: [DFA<LexerATNConfig>] = {
          var decisionToDFA = [DFA<LexerATNConfig>]()
          let length = LexerA._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(LexerA._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache: PredictionContextCache = PredictionContextCache()
	public static let A=1, B=2, C=3
	public static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public static let ruleNames: [String] = [
		"A", "B", "C"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'a'", "'b'", "'c'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "A", "B", "C"
	]
	public static let VOCABULARY: Vocabulary = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	//@Deprecated
	public let tokenNames: [String?]? = {
	    let length = _SYMBOLIC_NAMES.count
	    var tokenNames = [String?](repeating: nil, count: length)
		for i in 0..<length {
			var name = VOCABULARY.getLiteralName(i)
			if name == nil {
				name = VOCABULARY.getSymbolicName(i)
			}
			if name == nil {
				name = "<INVALID>"
			}
			tokenNames[i] = name
		}
		return tokenNames
	}()

	open func getTokenNames() -> [String?]? {
		return tokenNames
	}

    open override func getVocabulary() -> Vocabulary {
        return LexerA.VOCABULARY
    }

	public required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, LexerA._ATN, LexerA._decisionToDFA, LexerA._sharedContextCache)
	}

	override
	open func getGrammarFileName() -> String { return "LexerA.g4" }

    override
	open func getRuleNames() -> [String] { return LexerA.ruleNames }

	override
	open func getSerializedATN() -> String { return LexerA._serializedATN }

	override
	open func getChannelNames() -> [String] { return LexerA.channelNames }

	override
	open func getModeNames() -> [String] { return LexerA.modeNames }

	override
	open func getATN() -> ATN { return LexerA._ATN }

    public static let _serializedATN: String = LexerAATN().jsonString
	public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}
