import XCTest

@testable import Antlr4

class JavaScriptParserTests: XCTestCase {
    #if JS_TEST_FIXTURES

    func testFixtures() throws {
        // 13.93 (13.93) seconds - after setup
        // 13.066 (13.066) seconds - after making Interval a struct
        // 13.037 (13.037) seconds - after making MultiMap a struct
        // (making BitSet a struct failed)
        // 12.712 (12.712) seconds - after making IntervalSet a struct
        // 12.753 (12.753) seconds - after removing Throws from IntervalSet
        // 12.797 (12.797) seconds - after addressing hot path in Utils.testBitLeftShiftArray (cherry-pick of 4d91ac0f6ae9104df88a30c83232ee43d113333b)
        // 12.345 (12.345) seconds - after cherry-pick of "Convert Vocabulary and ParseTreeMatch to structs" (90ad3ff6cd8e792fbb65dfd7837c1772972cfa95)
        // 12.689 (12.689) seconds - after cherry-pick of "Removing some dubious operator overloads and simplifying some methods" (0a49b1e7794c001d408fba1fb9f39f64a1addb01)
        // 6.295 (6.295) seconds - after enabling multithreading
        // 5.519 seconds - in Linux machine
        let urls = try XCTUnwrap(Bundle.module.urls(forResourcesWithExtension: ".js", subdirectory: nil))

        let exp = expectation(description: "JSON parsing test")
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 8

        for url in urls {
            let url = url as URL
            let outputUrl = _findOutputPath(url)

            queue.addOperation {
                do {
                    try self._runTest(inputUrl: url, outputUrl: outputUrl, record: false)
                } catch {

                }
            }
        }

        queue.addBarrierBlock {
            exp.fulfill()
        }

        waitForExpectations(timeout: 30.0)
    }

    #endif

    private func _findOutputPath(_ jsFileInput: URL) -> URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .appendingPathComponent("TestResults")
            .appendingPathComponent(jsFileInput.lastPathComponent)
            .appendingPathExtension("output")
    }

    private func _runTest(inputUrl: URL, outputUrl: URL, record: Bool = false, line: UInt = #line) throws {
        let input = try String(contentsOf: inputUrl)

        let lexer = JavaScriptLexer(ANTLRInputStream(input))
        let tokenStream = CommonTokenStream(lexer)
        let parser = try JavaScriptParser(tokenStream)
        let listener = AntlrDiagnosticsErrorListener()
        
        parser.addErrorListener(listener)

        let _ = try parser.program()

        let serialized = AntlrDiagnosticSerializer.serialize(listener.diagnostics)

        if record {
            try serialized.write(to: outputUrl, atomically: true, encoding: .utf8)
            XCTFail("Successfully recorded sample at \(outputUrl).")
        } else {
            let output = try String(contentsOf: outputUrl)
            if serialized != output {
                print("Failed test file \(inputUrl.lastPathComponent)")
            }

            _diffTest(expected: output).diff(serialized)
        }
    }

    private func _diffTest(expected: String, line: UInt = #line) -> DiffingTest {
        let string = DiffableString(string: expected, location: .init(file: #file, line: line))

        return DiffingTest(expected: string, testCase: self, highlightLineInEditor: false, diffOnly: true)
    }
}

enum AntlrDiagnostic {
    case syntaxError(line: Int, charPositionInLine: Int, msg: String)
    case ambiguity(startIndex: Int, stopIndex: Int, exact: Bool, ambiguousAlts: String, configs: String)
    case attemptingFullContext(startIndex: Int, stopIndex: Int, conflictingAlts: String?, configs: String)
    case contextSensitivity(startIndex: Int, stopIndex: Int, prediction: Int, configs: String)
}

enum AntlrDiagnosticSerializer {
    static func serialize(_ diagnostics: [AntlrDiagnostic]) -> String {
        var output: String = ""

        func addLine(_ string: String) {
            if !output.isEmpty {
                output.append("\n")
            }
            output.append(string)
        }

        for diagnostic in diagnostics {
            switch diagnostic {
            case .syntaxError(line: let line, charPositionInLine: let charPositionInLine, msg: let msg):
                addLine("syntaxError(line: \(line), charPositionInLine: \(charPositionInLine), msg: \"\(msg)\")")

            case .ambiguity(startIndex: let startIndex, stopIndex: let stopIndex, exact: let exact, ambiguousAlts: let ambiguousAlts, configs: _):
                addLine("ambiguity(startIndex: \(startIndex), stopIndex: \(stopIndex), exact: \(exact), ambiguousAlts: \"\(ambiguousAlts)\")")

            case .attemptingFullContext(startIndex: let startIndex, stopIndex: let stopIndex, conflictingAlts: let conflictingAlts, configs: _):
                addLine("attemptingFullContext(startIndex: \(startIndex), stopIndex: \(stopIndex), ambiguousAlts: \"\(conflictingAlts ?? "<nil>")\")")

            case .contextSensitivity(startIndex: let startIndex, stopIndex: let stopIndex, prediction: let prediction, configs: _):
                addLine("contextSensitivity(startIndex: \(startIndex), stopIndex: \(stopIndex), prediction: \(prediction))")
            }
        }

        return output
    }
}

class AntlrDiagnosticsErrorListener: BaseErrorListener {
    var diagnostics: [AntlrDiagnostic] = []

    override init() {
        super.init()
    }
    
    override func syntaxError<T>(_ recognizer: Recognizer<T>,
                                 _ offendingSymbol: AnyObject?,
                                 _ line: Int,
                                 _ charPositionInLine: Int,
                                 _ msg: String,
                                 _ e: AnyObject?) where T : ATNSimulator {
        
        diagnostics.append(
            .syntaxError(
                line: line,
                charPositionInLine: charPositionInLine,
                msg: msg
            )
        )
    }

    override func reportAmbiguity(_ recognizer: Parser,
                                  _ dfa: DFAParser,
                                  _ startIndex: Int,
                                  _ stopIndex: Int,
                                  _ exact: Bool,
                                  _ ambiguousAlts: BitSet,
                                  _ configs: ATNConfigSetParser) {
        
        diagnostics.append(
            .ambiguity(
                startIndex: startIndex,
                stopIndex: stopIndex,
                exact: exact,
                ambiguousAlts: ambiguousAlts.description,
                configs: configs.count.description
            )
        )
    }

    override func reportAttemptingFullContext(_ recognizer: Parser,
                                              _ dfa: DFAParser,
                                              _ startIndex: Int,
                                              _ stopIndex: Int,
                                              _ conflictingAlts: BitSet?,
                                              _ configs: ATNConfigSetParser) {

        diagnostics.append(
            .attemptingFullContext(
                startIndex: startIndex,
                stopIndex: stopIndex,
                conflictingAlts: conflictingAlts.map(\.description),
                configs: configs.count.description
            )
        )
    }

    override func reportContextSensitivity(_ recognizer: Parser,
                                           _ dfa: DFAParser,
                                           _ startIndex: Int,
                                           _ stopIndex: Int,
                                           _ prediction: Int,
                                           _ configs: ATNConfigSetParser) {

        diagnostics.append(
            .contextSensitivity(
                startIndex: startIndex,
                stopIndex: stopIndex,
                prediction: prediction,
                configs: configs.count.description
            )
        )
    }
}
