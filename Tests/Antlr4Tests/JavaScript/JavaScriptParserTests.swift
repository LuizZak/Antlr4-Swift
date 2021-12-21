import XCTest

@testable import Antlr4

class JavaScriptParserTests: XCTestCase {
    func testFixtures() throws {
        // 13.93 (13.93) seconds - after setup
        // 13.066 (13.066) seconds - after making Interval a struct
        let urls = try XCTUnwrap(Bundle.module.urls(forResourcesWithExtension: ".js", subdirectory: nil))

        for url in urls {
            let url = url as URL
            let outputUrl = _findOutputPath(url)

            try _runTest(inputUrl: url, outputUrl: outputUrl, record: false)
        }
    }

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
