// Generated from /Users/luizsilva/Documents/Local Projects/antlr4-swift/Tests/Antlr4Tests/LexerB.g4 by ANTLR 4.7
import Antlr4

open class LexerB: Lexer {
	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = LexerB._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(LexerB._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache:PredictionContextCache = PredictionContextCache()
	public static let ID=1, INT=2, SEMI=3, MUL=4, PLUS=5, ASSIGN=6, WS=7
	public static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public static let ruleNames: [String] = [
		"ID", "INT", "SEMI", "MUL", "PLUS", "ASSIGN", "WS"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, nil, "';'", "'*'", "'+'", "'='"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "ID", "INT", "SEMI", "MUL", "PLUS", "ASSIGN", "WS"
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
        return LexerB.VOCABULARY
    }

	public required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, LexerB._ATN, LexerB._decisionToDFA, LexerB._sharedContextCache)
	}

	override
	open func getGrammarFileName() -> String { return "LexerB.g4" }

    override
	open func getRuleNames() -> [String] { return LexerB.ruleNames }

	override
	open func getSerializedATN() -> String { return LexerB._serializedATN }

	override
	open func getChannelNames() -> [String] { return LexerB.channelNames }

	override
	open func getModeNames() -> [String] { return LexerB.modeNames }

	override
	open func getATN() -> ATN { return LexerB._ATN }

    public static let _serializedATN: String = LexerBATN().jsonString
	public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}