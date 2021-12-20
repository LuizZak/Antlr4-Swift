// Generated from Threading.g4 by ANTLR 4.9.3
import Antlr4

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link ThreadingParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
open class ThreadingVisitor<T>: ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link ThreadingParser#s}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitS(_ ctx: ThreadingParser.SContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code add}
	 * labeled alternative in {@link ThreadingParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitAdd(_ ctx: ThreadingParser.AddContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code number}
	 * labeled alternative in {@link ThreadingParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitNumber(_ ctx: ThreadingParser.NumberContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code multiply}
	 * labeled alternative in {@link ThreadingParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitMultiply(_ ctx: ThreadingParser.MultiplyContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

}