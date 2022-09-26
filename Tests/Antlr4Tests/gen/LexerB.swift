// Generated from java-escape by ANTLR 4.11.1
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

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let ID=1, INT=2, SEMI=3, MUL=4, PLUS=5, ASSIGN=6, WS=7

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
		"ID", "INT", "SEMI", "MUL", "PLUS", "ASSIGN", "WS"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, nil, "';'", "'*'", "'+'", "'='"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "ID", "INT", "SEMI", "MUL", "PLUS", "ASSIGN", "WS"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)


	override open
	func getVocabulary() -> Vocabulary {
		return LexerB.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.11.1", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, LexerB._ATN, LexerB._decisionToDFA, LexerB._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "LexerB.g4" }

	override open
	func getRuleNames() -> [String] { return LexerB.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return LexerB._serializedATN }

	override open
	func getChannelNames() -> [String] { return LexerB.channelNames }

	override open
	func getModeNames() -> [String] { return LexerB.modeNames }

	override open
	func getATN() -> ATN { return LexerB._ATN }

	static let _serializedATN:[Int] = [
		4,0,7,38,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
		1,0,4,0,17,8,0,11,0,12,0,18,1,1,4,1,22,8,1,11,1,12,1,23,1,2,1,2,1,3,1,
		3,1,4,1,4,1,5,1,5,1,6,4,6,35,8,6,11,6,12,6,36,0,0,7,1,1,3,2,5,3,7,4,9,
		5,11,6,13,7,1,0,0,40,0,1,1,0,0,0,0,3,1,0,0,0,0,5,1,0,0,0,0,7,1,0,0,0,0,
		9,1,0,0,0,0,11,1,0,0,0,0,13,1,0,0,0,1,16,1,0,0,0,3,21,1,0,0,0,5,25,1,0,
		0,0,7,27,1,0,0,0,9,29,1,0,0,0,11,31,1,0,0,0,13,34,1,0,0,0,15,17,2,97,122,
		0,16,15,1,0,0,0,17,18,1,0,0,0,18,16,1,0,0,0,18,19,1,0,0,0,19,2,1,0,0,0,
		20,22,2,48,57,0,21,20,1,0,0,0,22,23,1,0,0,0,23,21,1,0,0,0,23,24,1,0,0,
		0,24,4,1,0,0,0,25,26,5,59,0,0,26,6,1,0,0,0,27,28,5,42,0,0,28,8,1,0,0,0,
		29,30,5,43,0,0,30,10,1,0,0,0,31,32,5,61,0,0,32,12,1,0,0,0,33,35,5,32,0,
		0,34,33,1,0,0,0,35,36,1,0,0,0,36,34,1,0,0,0,36,37,1,0,0,0,37,14,1,0,0,
		0,4,0,18,23,36,0
	]

	public
	static let _ATN: ATN = try! ATNDeserializer().deserialize(_serializedATN)
}