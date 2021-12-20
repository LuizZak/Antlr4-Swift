// Generated from Threading.g4 by ANTLR 4.9.3
import Antlr4

open class ThreadingLexer: Lexer {

    public class State {
        public let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
        
        internal var _decisionToDFA: [DFA<LexerATNConfig>]
        internal let _sharedContextCache: PredictionContextCache = PredictionContextCache()
        let atnConfigPool: LexerATNConfigPool = LexerATNConfigPool()
        
        public init() {
            var decisionToDFA = [DFA<LexerATNConfig>]()
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
    internal var _decisionToDFA: [DFA<LexerATNConfig>] {
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
    init(_ input: CharStream, _ state: State) {
        self.state = state
        
        RuntimeMetaData.checkVersion("4.9.3", RuntimeMetaData.VERSION)
        super.init(input)
        _interp = LexerATNSimulator(self,
                                    _ATN,
                                    _decisionToDFA,
                                    _sharedContextCache,
                                    lexerAtnConfigPool: state.atnConfigPool)
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
