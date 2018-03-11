// Generated from /Users/luizsilva/Documents/Local Projects/antlr4-swift/Tests/Antlr4Tests/VisitorCalc.g4 by ANTLR 4.7
import Antlr4

open class VisitorCalcLexer: Lexer {
	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = VisitorCalcLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(VisitorCalcLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache: PredictionContextCache = PredictionContextCache()
	public static let INT=1, MUL=2, DIV=3, ADD=4, SUB=5, WS=6
	public static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public static let ruleNames: [String] = [
		"INT", "MUL", "DIV", "ADD", "SUB", "WS"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, "'*'", "'/'", "'+'", "'-'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "INT", "MUL", "DIV", "ADD", "SUB", "WS"
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
        return VisitorCalcLexer.VOCABULARY
    }

	public required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, VisitorCalcLexer._ATN, VisitorCalcLexer._decisionToDFA, VisitorCalcLexer._sharedContextCache)
	}

	override
	open func getGrammarFileName() -> String { return "VisitorCalc.g4" }

    override
	open func getRuleNames() -> [String] { return VisitorCalcLexer.ruleNames }

	override
	open func getSerializedATN() -> String { return VisitorCalcLexer._serializedATN }

	override
	open func getChannelNames() -> [String] { return VisitorCalcLexer.channelNames }

	override
	open func getModeNames() -> [String] { return VisitorCalcLexer.modeNames }

	override
	open func getATN() -> ATN { return VisitorCalcLexer._ATN }

    public static let _serializedATN: String = VisitorCalcLexerATN().jsonString
	public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}
