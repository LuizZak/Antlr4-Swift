// Generated from java-escape by ANTLR 4.11.1
import Antlr4

open class ThreadingParser: Parser {

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
	enum Tokens: Int {
		case EOF = -1, INT = 1, MUL = 2, DIV = 3, ADD = 4, SUB = 5, WS = 6
	}

	public
	static let RULE_s = 0, RULE_expr = 1

	public
	static let ruleNames: [String] = [
		"s", "expr"
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
	func getGrammarFileName() -> String { return "java-escape" }

	override open
	func getRuleNames() -> [String] { return ThreadingParser.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return ThreadingParser._serializedATN }

	override open
	func getATN() -> ATN { return _ATN }


    override public convenience
    init(_ input: TokenStream) throws {
        try self.init(input, State())
    }
    
    public
    init(_ input: TokenStream, _ state: State) throws {
        self.state = state
        RuntimeMetaData.checkVersion("4.11.1", RuntimeMetaData.VERSION)
        try super.init(input)
        _interp = ParserATNSimulator(self, _ATN, _decisionToDFA, _sharedContextCache)
    }


	public class SContext: ParserRuleContext {
			open
			func expr() -> ExprContext? {
				return getRuleContext(ExprContext.self, 0)
			}
			open
			func EOF() -> TerminalNode? {
				return getToken(ThreadingParser.Tokens.EOF.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return ThreadingParser.RULE_s
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.enterS(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.exitS(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? ThreadingVisitor {
			    return visitor.visitS(self)
			}
			else if let visitor = visitor as? ThreadingBaseVisitor {
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
		try enterRule(_localctx, 0, ThreadingParser.RULE_s)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(4)
		 	try expr(0)
		 	setState(5)
		 	try match(ThreadingParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}


	public class ExprContext: ParserRuleContext {
		override open
		func getRuleIndex() -> Int {
			return ThreadingParser.RULE_expr
		}
	}
	public class AddContext: ExprContext {
			open
			func expr() -> [ExprContext] {
				return getRuleContexts(ExprContext.self)
			}
			open
			func expr(_ i: Int) -> ExprContext? {
				return getRuleContext(ExprContext.self, i)
			}
			open
			func ADD() -> TerminalNode? {
				return getToken(ThreadingParser.Tokens.ADD.rawValue, 0)
			}
			open
			func SUB() -> TerminalNode? {
				return getToken(ThreadingParser.Tokens.SUB.rawValue, 0)
			}

		public
		init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.enterAdd(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.exitAdd(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? ThreadingVisitor {
			    return visitor.visitAdd(self)
			}
			else if let visitor = visitor as? ThreadingBaseVisitor {
			    return visitor.visitAdd(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class NumberContext: ExprContext {
			open
			func INT() -> TerminalNode? {
				return getToken(ThreadingParser.Tokens.INT.rawValue, 0)
			}

		public
		init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.enterNumber(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.exitNumber(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? ThreadingVisitor {
			    return visitor.visitNumber(self)
			}
			else if let visitor = visitor as? ThreadingBaseVisitor {
			    return visitor.visitNumber(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class MultiplyContext: ExprContext {
			open
			func expr() -> [ExprContext] {
				return getRuleContexts(ExprContext.self)
			}
			open
			func expr(_ i: Int) -> ExprContext? {
				return getRuleContext(ExprContext.self, i)
			}
			open
			func MUL() -> TerminalNode? {
				return getToken(ThreadingParser.Tokens.MUL.rawValue, 0)
			}
			open
			func DIV() -> TerminalNode? {
				return getToken(ThreadingParser.Tokens.DIV.rawValue, 0)
			}

		public
		init(_ ctx: ExprContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.enterMultiply(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? ThreadingListener {
				listener.exitMultiply(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? ThreadingVisitor {
			    return visitor.visitMultiply(self)
			}
			else if let visitor = visitor as? ThreadingBaseVisitor {
			    return visitor.visitMultiply(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}

	 public final  func expr( ) throws -> ExprContext   {
		return try expr(0)
	}
	@discardableResult
	private func expr(_ _p: Int) throws -> ExprContext   {
		let _parentctx: ParserRuleContext? = _ctx
		let _parentState: Int = getState()
		var _localctx: ExprContext
		_localctx = ExprContext(_ctx, _parentState)
		let _startState: Int = 2
		try enterRecursionRule(_localctx, 2, ThreadingParser.RULE_expr, _p)
		var _la: Int = 0
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			_localctx = NumberContext(_localctx)
			_ctx = _localctx

			setState(8)
			try match(ThreadingParser.Tokens.INT.rawValue)

			_ctx!.stop = try _input.LT(-1)
			setState(18)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					setState(16)
					try _errHandler.sync(self)
					switch(try getInterpreter().adaptivePredict(_input,0, _ctx)) {
					case 1:
						_localctx = MultiplyContext(  ExprContext(_parentctx, _parentState))
						try pushNewRecursionContext(_localctx, _startState, ThreadingParser.RULE_expr)
						setState(10)
						if (!(precpred(_ctx, 2))) {
						    throw ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 2)"))
						}
						setState(11)
						_la = try _input.LA(1)
						if (!(_la == ThreadingParser.Tokens.MUL.rawValue || _la == ThreadingParser.Tokens.DIV.rawValue)) {
						try _errHandler.recoverInline(self)
						}
						else {
							_errHandler.reportMatch(self)
							try consume()
						}
						setState(12)
						try expr(3)

						break
					case 2:
						_localctx = AddContext(  ExprContext(_parentctx, _parentState))
						try pushNewRecursionContext(_localctx, _startState, ThreadingParser.RULE_expr)
						setState(13)
						if (!(precpred(_ctx, 1))) {
						    throw ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
						}
						setState(14)
						_la = try _input.LA(1)
						if (!(_la == ThreadingParser.Tokens.ADD.rawValue || _la == ThreadingParser.Tokens.SUB.rawValue)) {
						try _errHandler.recoverInline(self)
						}
						else {
							_errHandler.reportMatch(self)
							try consume()
						}
						setState(15)
						try expr(2)

						break
					default: break
					}
			 
				}
				setState(20)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}

	override open
	func sempred(_ _localctx: RuleContext?, _ ruleIndex: Int,  _ predIndex: Int)throws -> Bool {
		switch (ruleIndex) {
		case  1:
			return try expr_sempred(_localctx?.castdown(ExprContext.self), predIndex)
	    default: return true
		}
	}
	private func expr_sempred(_ _localctx: ExprContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 0:return precpred(_ctx, 2)
		    case 1:return precpred(_ctx, 1)
		    default: return true
		}
	}

	static let _serializedATN:[Int] = [
		4,1,6,22,2,0,7,0,2,1,7,1,1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,5,1,17,8,1,10,1,12,1,20,9,1,1,1,0,1,2,2,0,2,0,2,1,0,2,3,1,0,4,5,21,0,
		4,1,0,0,0,2,7,1,0,0,0,4,5,3,2,1,0,5,6,5,0,0,1,6,1,1,0,0,0,7,8,6,1,-1,0,
		8,9,5,1,0,0,9,18,1,0,0,0,10,11,10,2,0,0,11,12,7,0,0,0,12,17,3,2,1,3,13,
		14,10,1,0,0,14,15,7,1,0,0,15,17,3,2,1,2,16,10,1,0,0,0,16,13,1,0,0,0,17,
		20,1,0,0,0,18,16,1,0,0,0,18,19,1,0,0,0,19,3,1,0,0,0,20,18,1,0,0,0,2,16,
		18
	]
}