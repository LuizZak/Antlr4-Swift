// swift-tools-version:5.4
// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
// Use of this file is governed by the BSD 3-clause license that
// can be found in the LICENSE.txt file in the project root.

import PackageDescription

let package = Package(
    name: "Antlr4",
    products: [
        .library(
            name: "Antlr4",
            targets: ["Antlr4"])
    ],
    targets: [
        .target(
            name: "CAntlrShims",
            dependencies: []),
        .target(
            name: "Antlr4",
            dependencies: ["CAntlrShims"]),
        .testTarget(
            name: "Antlr4Tests",
            dependencies: ["Antlr4"],
            exclude: [
                "gen/LexerA.interp",
                "gen/LexerA.tokens",
                "gen/LexerB.interp",
                "gen/LexerB.tokens",
                "Threading.g4",
                "gen/VisitorBasicLexer.tokens",
                "gen/VisitorBasic.interp",
                "VisitorBasic.g4",
                "gen/ThreadingLexer.tokens",
                "LexerB.g4",
                "gen/VisitorCalcLexer.tokens",
                "gen/VisitorCalcLexer.interp",
                "LexerA.g4",
                "gen/VisitorBasicLexer.interp",
                "gen/VisitorCalc.interp",
                "gen/Threading.interp",
                "gen/Threading.tokens",
                "VisitorCalc.g4",
                "gen/VisitorCalc.tokens",
                "gen/VisitorBasic.tokens",
                "gen/ThreadingLexer.interp",
                "JavaScript/TestResults/bezier.js.output",
                "JavaScript/TestResults/utils.js.output",
                "JavaScript/TestResults/EnhancedRegularExpression.js.output",
                "JavaScript/TestResults/Function.js.output",
                "JavaScript/TestResults/TemplateStrings.js.output",
                "JavaScript/TestResults/Classes.js.output",
                "JavaScript/TestResults/Stage3.js.output",
                "JavaScript/TestResults/ClassInNonGlobalStrict.js.output",
                "JavaScript/TestResults/ObjectInitializer.js.output",
                "JavaScript/TestResults/DestructuringAssignment.js.output",
                "JavaScript/TestResults/SymbolType.js.output",
                "JavaScript/TestResults/Generators.js.output",
                "JavaScript/TestResults/LetAndAsync.js.output",
                "JavaScript/TestResults/Iterators.js.output",
                "JavaScript/TestResults/Issue2178NewExpression.js.output",
                "JavaScript/TestResults/EnhancedObjectProperties.js.output",
                "JavaScript/TestResults/Modules.js.output",
                "JavaScript/TestResults/TypedArrays.js.output",
                "JavaScript/TestResults/MapSetAndWeakMapWeakSet.js.output",
                "JavaScript/TestResults/TemplateLiterals.js.output",
                "JavaScript/TestResults/ExtendedLiterals.js.output",
                "JavaScript/TestResults/Constants.js.output",
                "JavaScript/TestResults/Promises.js.output",
                "JavaScript/TestResults/Outdated.js.output",
                "JavaScript/TestResults/Misc.js.output",
                "JavaScript/TestResults/ExtendedParameterHandling.js.output",
                "JavaScript/TestResults/Scoping.js.output",
                "JavaScript/TestResults/NewBuildInMethods.js.output",
                "JavaScript/TestResults/StrictGlobal.js.output",
                "JavaScript/TestResults/ArrowFunctions.js.output",
                "JavaScript/TestResults/AsyncAwait.js.output",
                "JavaScript/TestResults/StrictFunctions.js.output",
                "JavaScript/TestResults/Meta-Programming.js.output",
                "JavaScript/TestResults/InternationalizationAndLocalization.js.output",
            ],
            resources: [
                .copy("JavaScript/Fixtures/bezier.js"),
                .copy("JavaScript/Fixtures/utils.js"),
                .copy("JavaScript/Fixtures/EnhancedRegularExpression.js"),
                .copy("JavaScript/Fixtures/Function.js"),
                .copy("JavaScript/Fixtures/TemplateStrings.js"),
                .copy("JavaScript/Fixtures/Classes.js"),
                .copy("JavaScript/Fixtures/Stage3.js"),
                .copy("JavaScript/Fixtures/ClassInNonGlobalStrict.js"),
                .copy("JavaScript/Fixtures/ObjectInitializer.js"),
                .copy("JavaScript/Fixtures/DestructuringAssignment.js"),
                .copy("JavaScript/Fixtures/SymbolType.js"),
                .copy("JavaScript/Fixtures/Generators.js"),
                .copy("JavaScript/Fixtures/LetAndAsync.js"),
                .copy("JavaScript/Fixtures/Iterators.js"),
                .copy("JavaScript/Fixtures/Issue2178NewExpression.js"),
                .copy("JavaScript/Fixtures/EnhancedObjectProperties.js"),
                .copy("JavaScript/Fixtures/Modules.js"),
                .copy("JavaScript/Fixtures/TypedArrays.js"),
                .copy("JavaScript/Fixtures/MapSetAndWeakMapWeakSet.js"),
                .copy("JavaScript/Fixtures/TemplateLiterals.js"),
                .copy("JavaScript/Fixtures/ExtendedLiterals.js"),
                .copy("JavaScript/Fixtures/Constants.js"),
                .copy("JavaScript/Fixtures/Promises.js"),
                .copy("JavaScript/Fixtures/Outdated.js"),
                .copy("JavaScript/Fixtures/Misc.js"),
                .copy("JavaScript/Fixtures/ExtendedParameterHandling.js"),
                .copy("JavaScript/Fixtures/Scoping.js"),
                .copy("JavaScript/Fixtures/NewBuildInMethods.js"),
                .copy("JavaScript/Fixtures/StrictGlobal.js"),
                .copy("JavaScript/Fixtures/ArrowFunctions.js"),
                .copy("JavaScript/Fixtures/AsyncAwait.js"),
                .copy("JavaScript/Fixtures/StrictFunctions.js"),
                .copy("JavaScript/Fixtures/Meta-Programming.js"),
                .copy("JavaScript/Fixtures/InternationalizationAndLocalization.js"),
            ])
    ],
    swiftLanguageVersions: [.v5]
)
