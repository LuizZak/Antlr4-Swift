// Generated from java-escape by ANTLR 4.11.1
import Antlr4

open class VisitorBasicParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = VisitorBasicParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(VisitorBasicParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, A = 1
	}

	public
	static let RULE_s = 0

	public
	static let ruleNames: [String] = [
		"s"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'A'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "A"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	override open
	func getGrammarFileName() -> String { return "java-escape" }

	override open
	func getRuleNames() -> [String] { return VisitorBasicParser.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return VisitorBasicParser._serializedATN }

	override open
	func getATN() -> ATN { return VisitorBasicParser._ATN }


	override open
	func getVocabulary() -> Vocabulary {
	    return VisitorBasicParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.11.1", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,VisitorBasicParser._ATN,VisitorBasicParser._decisionToDFA, VisitorBasicParser._sharedContextCache)
	}


	public class SContext: ParserRuleContext {
			open
			func A() -> TerminalNode? {
				return getToken(VisitorBasicParser.Tokens.A.rawValue, 0)
			}
			open
			func EOF() -> TerminalNode? {
				return getToken(VisitorBasicParser.Tokens.EOF.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return VisitorBasicParser.RULE_s
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? VisitorBasicListener {
				listener.enterS(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? VisitorBasicListener {
				listener.exitS(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? VisitorBasicVisitor {
			    return visitor.visitS(self)
			}
			else if let visitor = visitor as? VisitorBasicBaseVisitor {
			    return visitor.visitS(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func s() throws -> SContext {
		var _localctx: SContext
		_localctx = SContext(_ctx, getState())
		try enterRule(_localctx, 0, VisitorBasicParser.RULE_s)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(2)
		 	try match(VisitorBasicParser.Tokens.A.rawValue)
		 	setState(3)
		 	try match(VisitorBasicParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	static let _serializedATN:[Int] = [
		4,1,1,6,2,0,7,0,1,0,1,0,1,0,1,0,0,0,1,0,0,0,4,0,2,1,0,0,0,2,3,5,1,0,0,
		3,4,5,0,0,1,4,1,1,0,0,0,0
	]

	public
	static let _ATN = try! ATNDeserializer().deserialize(_serializedATN)
}