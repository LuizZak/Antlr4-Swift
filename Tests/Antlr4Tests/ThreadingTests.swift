/// Copyright (c) 2012-2021 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
import XCTest
import Antlr4

class ThreadingTests: XCTestCase {
    static let allTests = [
        // ("testParallelExecution", testParallelExecution),
        ("testParallelExecution_stateful", testParallelExecution_stateful),
    ]

    // NOTE: This test is now unsafe as state differentiation is left up to
    // NOTE: generated Parser/Lexer classes
    #if false

    ///
    /// This test verifies parallel execution of the parser
    ///
    func testParallelExecution() throws {
        let input = [
            "2 * 8 - 4",
            "2 + 8 / 4",
            "2 - 8 - 4",
            "2 * 8 * 4",
            "2 / 8 / 4",
            "2 + 8 + 4",
            "890",
        ]
        let expectation = expectation(description: "Waiting on async-task")
        expectation.expectedFulfillmentCount = 100
        for i in 1...100 {
            DispatchQueue.global().async {
                let lexer = ThreadingLexer(ANTLRInputStream(input[i % 7]))
                let tokenStream = CommonTokenStream(lexer)
                let parser = try? ThreadingParser(tokenStream)

                let _ = try? parser?.s()

                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30.0) { (_) in
            print("Completed")
        }
    }

    #endif

    func testParallelExecution_stateful() throws {
        let input = [
            "2 * 8 - 4",
            "2 + 8 / 4",
            "2 - 8 - 4",
            "2 * 8 * 4",
            "2 / 8 / 4",
            "2 + 8 + 4",
            "890",
        ]
        let expectation = expectation(description: "Waiting on async-task")
        expectation.expectedFulfillmentCount = 100
        for i in 1...100 {
            DispatchQueue.global().async {
                let lexer = ThreadingLexer(ANTLRInputStream(input[i % 7]), .init())
                let tokenStream = CommonTokenStream(lexer)
                let parser = try? ThreadingParser(tokenStream, .init())

                let _ = try? parser?.s()

                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30.0) { (_) in
            print("Completed")
        }
    }
}
