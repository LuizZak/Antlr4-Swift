// Generated from /Users/luizsilva/Documents/Local Projects/antlr4-swift/Tests/Antlr4Tests/VisitorBasic.g4 by ANTLR 4.7
import Antlr4

open class VisitorBasicParser: Parser {

	internal static var _decisionToDFA: [DFA<ParserATNConfig>] = {
          var decisionToDFA = [DFA<ParserATNConfig>]()
          let length = VisitorBasicParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(VisitorBasicParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()
	internal static let _sharedContextCache: PredictionContextCache = PredictionContextCache()
	public enum Tokens: Int {
		case EOF = -1, A = 1
	}
	public static let RULE_s = 0
	public static let ruleNames: [String] = [
		"s"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'A'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "A"
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

	override
	open func getGrammarFileName() -> String { return "VisitorBasic.g4" }

	override
	open func getRuleNames() -> [String] { return VisitorBasicParser.ruleNames }

	override
	open func getSerializedATN() -> String { return VisitorBasicParser._serializedATN }

	override
	open func getATN() -> ATN { return VisitorBasicParser._ATN }

	open override func getVocabulary() -> Vocabulary {
	    return VisitorBasicParser.VOCABULARY
	}

	public override init(_ input: TokenStream)throws {
	    RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self, VisitorBasicParser._ATN, VisitorBasicParser._decisionToDFA, VisitorBasicParser._sharedContextCache)
	}
	open class SContext: ParserRuleContext {
		open func EOF() -> TerminalNode? { return getToken(VisitorBasicParser.Tokens.EOF.rawValue, 0) }
		open override func getRuleIndex() -> Int { return VisitorBasicParser.RULE_s }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is VisitorBasicListener {
			 	(listener as! VisitorBasicListener).enterS(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is VisitorBasicListener {
			 	(listener as! VisitorBasicListener).exitS(self)
			}
		}
		override
		open func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if visitor is VisitorBasicVisitor {
			     return (visitor as! VisitorBasicVisitor<T>).visitS(self)
			} else if visitor is VisitorBasicBaseVisitor {
		    	 return (visitor as! VisitorBasicBaseVisitor<T>).visitS(self)
		    } else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	open func s() throws -> SContext {
		let _localctx: SContext = SContext(_ctx, getState())
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

		} catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

   public static let _serializedATN: String = VisitorBasicParserATN().jsonString
   public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}
