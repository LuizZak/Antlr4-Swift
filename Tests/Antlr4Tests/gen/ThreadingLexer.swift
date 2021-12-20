// Generated from Tests/Antlr4Tests/Threading.g4 by ANTLR 4.9.3
import Antlr4

open class ThreadingLexer: Lexer {

	internal static var _decisionToDFA: [DFA<LexerATNConfig>] = {
          var decisionToDFA = [DFA<LexerATNConfig>]()
          let length = VisitorBasicLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(VisitorBasicLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
    }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let T__0=1, NUMBER=2, WS=3

	public
	static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public
	static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public
	static let ruleNames: [String] = [
		"T__0", "NUMBER", "WS"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'+'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, nil, "NUMBER", "WS"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)


	override open
	func getVocabulary() -> Vocabulary {
		return ThreadingLexer.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.9.3", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, ThreadingLexer._ATN, ThreadingLexer._decisionToDFA, ThreadingLexer._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "Threading.g4" }

	override open
	func getRuleNames() -> [String] { return ThreadingLexer.ruleNames }

	override open
	func getSerializedATN() -> String { return ThreadingLexer._serializedATN }

	override open
	func getChannelNames() -> [String] { return ThreadingLexer.channelNames }

	override open
	func getModeNames() -> [String] { return ThreadingLexer.modeNames }

	override open
	func getATN() -> ATN { return ThreadingLexer._ATN }


	public
	static let _serializedATN: String = ThreadingLexerATN().jsonString

	public
	static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}