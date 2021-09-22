// Generated from /Users/luizsilva/Documents/Local Projects/antlr4-swift/Tests/Antlr4Tests/VisitorBasic.g4 by ANTLR 4.7
import Antlr4

open class VisitorBasicLexer: Lexer {
	internal static var _decisionToDFA: [DFA<LexerATNConfig>] = {
          var decisionToDFA = [DFA<LexerATNConfig>]()
          let length = VisitorBasicLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(VisitorBasicLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache: PredictionContextCache = PredictionContextCache()
	public static let A=1
	public static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public static let ruleNames: [String] = [
		"A"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'A'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "A"
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
        return VisitorBasicLexer.VOCABULARY
    }

	public required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, VisitorBasicLexer._ATN, VisitorBasicLexer._decisionToDFA, VisitorBasicLexer._sharedContextCache)
	}

	override
	open func getGrammarFileName() -> String { return "VisitorBasic.g4" }

    override
	open func getRuleNames() -> [String] { return VisitorBasicLexer.ruleNames }

	override
	open func getSerializedATN() -> String { return VisitorBasicLexer._serializedATN }

	override
	open func getChannelNames() -> [String] { return VisitorBasicLexer.channelNames }

	override
	open func getModeNames() -> [String] { return VisitorBasicLexer.modeNames }

	override
	open func getATN() -> ATN { return VisitorBasicLexer._ATN }

    public static let _serializedATN: String = VisitorBasicLexerATN().jsonString
	public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}
