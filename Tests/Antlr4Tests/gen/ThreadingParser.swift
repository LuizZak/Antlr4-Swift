// Generated from Tests/Antlr4Tests/Threading.g4 by ANTLR 4.9.3
import Antlr4

open class ThreadingParser: Parser {

	internal static var _decisionToDFA: [DFA<ParserATNConfig>] = {
          var decisionToDFA = [DFA<ParserATNConfig>]()
          let length = VisitorBasicParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(VisitorBasicParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, T__0 = 1, NUMBER = 2, WS = 3
	}

	public
	static let RULE_operation = 0

	public
	static let ruleNames: [String] = [
		"operation"
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
	func getGrammarFileName() -> String { return "Threading.g4" }

	override open
	func getRuleNames() -> [String] { return ThreadingParser.ruleNames }

	override open
	func getSerializedATN() -> String { return ThreadingParser._serializedATN }

	override open
	func getATN() -> ATN { return ThreadingParser._ATN }


	override open
	func getVocabulary() -> Vocabulary {
	    return ThreadingParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.9.3", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,ThreadingParser._ATN,ThreadingParser._decisionToDFA, ThreadingParser._sharedContextCache)
	}


	public class OperationContext: ParserRuleContext {
		open var l: Token!
		open var op: Token!
		open var r: Token!
			open
			func NUMBER() -> [TerminalNode] {
				return getTokens(ThreadingParser.Tokens.NUMBER.rawValue)
			}
			open
			func NUMBER(_ i:Int) -> TerminalNode? {
				return getToken(ThreadingParser.Tokens.NUMBER.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return ThreadingParser.RULE_operation
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.enterOperation(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.exitOperation(self)
			}
		}
	}
	@discardableResult
	 open func operation() throws -> OperationContext {
		let _localctx: OperationContext = OperationContext(_ctx, getState())
		try enterRule(_localctx, 0, ThreadingParser.RULE_operation)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(2)
		 	try {
		 			let assignmentValue = try match(ThreadingParser.Tokens.NUMBER.rawValue)
		 			_localctx.castdown(OperationContext.self).l = assignmentValue
		 	     }()

		 	setState(3)
		 	try {
		 			let assignmentValue = try match(ThreadingParser.Tokens.T__0.rawValue)
		 			_localctx.castdown(OperationContext.self).op = assignmentValue
		 	     }()

		 	setState(4)
		 	try {
		 			let assignmentValue = try match(ThreadingParser.Tokens.NUMBER.rawValue)
		 			_localctx.castdown(OperationContext.self).r = assignmentValue
		 	     }()


		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}


	public
	static let _serializedATN = ThreadingParserATN().jsonString

	public
	static let _ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}