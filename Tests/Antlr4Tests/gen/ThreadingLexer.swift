// Generated from java-escape by ANTLR 4.11.1
import Antlr4

open class ThreadingLexer: Lexer {

    public class State {
        public let _ATN: ATN = try! ATNDeserializer().deserialize(_serializedATN)
        
        internal var _decisionToDFA: [DFA]
        internal let _sharedContextCache: PredictionContextCache = PredictionContextCache()
        
        public init() {
            var decisionToDFA = [DFA]()
            let length = _ATN.getNumberOfDecisions()
            for i in 0..<length {
                decisionToDFA.append(DFA(_ATN.getDecisionState(i)!, i))
            }
            _decisionToDFA = decisionToDFA
        }
    }
    
    public var _ATN: ATN {
        return state._ATN
    }
    internal var _decisionToDFA: [DFA] {
        return state._decisionToDFA
    }
    internal var _sharedContextCache: PredictionContextCache {
        return state._sharedContextCache
    }

    public var state: State
    
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

	public required convenience
 	init(_ input: CharStream) {
		self.init(input, State())
	}

	public
	required init(_ input: CharStream, _ state: State) {
		self.state = state

	    RuntimeMetaData.checkVersion("4.11.1", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, _ATN, _decisionToDFA, _sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "Threading.g4" }

	override open
	func getRuleNames() -> [String] { return ThreadingLexer.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return ThreadingLexer._serializedATN }

	override open
	func getChannelNames() -> [String] { return ThreadingLexer.channelNames }

	override open
	func getModeNames() -> [String] { return ThreadingLexer.modeNames }

	override open
	func getATN() -> ATN { return _ATN }

	static let _serializedATN:[Int] = [
		4,0,6,33,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,1,0,4,0,
		15,8,0,11,0,12,0,16,1,1,1,1,1,2,1,2,1,3,1,3,1,4,1,4,1,5,4,5,28,8,5,11,
		5,12,5,29,1,5,1,5,0,0,6,1,1,3,2,5,3,7,4,9,5,11,6,1,0,2,1,0,48,57,2,0,9,
		9,32,32,34,0,1,1,0,0,0,0,3,1,0,0,0,0,5,1,0,0,0,0,7,1,0,0,0,0,9,1,0,0,0,
		0,11,1,0,0,0,1,14,1,0,0,0,3,18,1,0,0,0,5,20,1,0,0,0,7,22,1,0,0,0,9,24,
		1,0,0,0,11,27,1,0,0,0,13,15,7,0,0,0,14,13,1,0,0,0,15,16,1,0,0,0,16,14,
		1,0,0,0,16,17,1,0,0,0,17,2,1,0,0,0,18,19,5,42,0,0,19,4,1,0,0,0,20,21,5,
		47,0,0,21,6,1,0,0,0,22,23,5,43,0,0,23,8,1,0,0,0,24,25,5,45,0,0,25,10,1,
		0,0,0,26,28,7,1,0,0,27,26,1,0,0,0,28,29,1,0,0,0,29,27,1,0,0,0,29,30,1,
		0,0,0,30,31,1,0,0,0,31,32,6,5,0,0,32,12,1,0,0,0,3,0,16,29,1,0,1,0
	]
}