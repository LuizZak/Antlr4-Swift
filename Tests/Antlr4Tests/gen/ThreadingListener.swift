// Generated from Threading.g4 by ANTLR 4.9.3
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link ThreadingParser}.
 */
public protocol ThreadingListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link ThreadingParser#s}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterS(_ ctx: ThreadingParser.SContext)
	/**
	 * Exit a parse tree produced by {@link ThreadingParser#s}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitS(_ ctx: ThreadingParser.SContext)
	/**
	 * Enter a parse tree produced by the {@code add}
	 * labeled alternative in {@link ThreadingParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAdd(_ ctx: ThreadingParser.AddContext)
	/**
	 * Exit a parse tree produced by the {@code add}
	 * labeled alternative in {@link ThreadingParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAdd(_ ctx: ThreadingParser.AddContext)
	/**
	 * Enter a parse tree produced by the {@code number}
	 * labeled alternative in {@link ThreadingParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNumber(_ ctx: ThreadingParser.NumberContext)
	/**
	 * Exit a parse tree produced by the {@code number}
	 * labeled alternative in {@link ThreadingParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNumber(_ ctx: ThreadingParser.NumberContext)
	/**
	 * Enter a parse tree produced by the {@code multiply}
	 * labeled alternative in {@link ThreadingParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterMultiply(_ ctx: ThreadingParser.MultiplyContext)
	/**
	 * Exit a parse tree produced by the {@code multiply}
	 * labeled alternative in {@link ThreadingParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitMultiply(_ ctx: ThreadingParser.MultiplyContext)
}