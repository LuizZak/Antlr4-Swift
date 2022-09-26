// Generated from java-escape by ANTLR 4.11.1
import Antlr4

open class LexerA: Lexer {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = LexerA._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(LexerA._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let A=1, B=2, C=3

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
		"A", "B", "C"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'a'", "'b'", "'c'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "A", "B", "C"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)


	override open
	func getVocabulary() -> Vocabulary {
		return LexerA.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.11.1", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, LexerA._ATN, LexerA._decisionToDFA, LexerA._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "LexerA.g4" }

	override open
	func getRuleNames() -> [String] { return LexerA.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return LexerA._serializedATN }

	override open
	func getChannelNames() -> [String] { return LexerA.channelNames }

	override open
	func getModeNames() -> [String] { return LexerA.modeNames }

	override open
	func getATN() -> ATN { return LexerA._ATN }

	static let _serializedATN:[Int] = [
		4,0,3,13,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,1,0,1,0,1,1,1,1,1,2,1,2,0,0,3,1,
		1,3,2,5,3,1,0,0,12,0,1,1,0,0,0,0,3,1,0,0,0,0,5,1,0,0,0,1,7,1,0,0,0,3,9,
		1,0,0,0,5,11,1,0,0,0,7,8,5,97,0,0,8,2,1,0,0,0,9,10,5,98,0,0,10,4,1,0,0,
		0,11,12,5,99,0,0,12,6,1,0,0,0,1,0,0
	]

	public
	static let _ATN: ATN = try! ATNDeserializer().deserialize(_serializedATN)
}