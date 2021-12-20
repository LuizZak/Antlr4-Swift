// Generated from Tests/Antlr4Tests/Threading.g4 by ANTLR 4.9.3
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link ThreadingParser}.
 */
public protocol ThreadingListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link ThreadingParser#operation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterOperation(_ ctx: ThreadingParser.OperationContext)
	/**
	 * Exit a parse tree produced by {@link ThreadingParser#operation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitOperation(_ ctx: ThreadingParser.OperationContext)
}