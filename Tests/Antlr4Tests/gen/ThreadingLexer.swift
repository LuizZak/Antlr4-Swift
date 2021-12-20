// Generated from Threading.g4 by ANTLR 4.9.3
import Antlr4

open class ThreadingLexer: Lexer {

	internal static var _decisionToDFA: [DFA<LexerATNConfig>] = {
          var decisionToDFA = [DFA<LexerATNConfig>]()
          let length = ThreadingLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(ThreadingLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let INT=1, MUL=2, DIV=3, ADD=4, SUB=5, WS=6

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
		"INT", "MUL", "DIV", "ADD", "SUB", "WS"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, "'*'", "'/'", "'+'", "'-'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "INT", "MUL", "DIV", "ADD", "SUB", "WS"
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