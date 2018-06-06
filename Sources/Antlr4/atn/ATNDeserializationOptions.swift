///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

///
///
/// -  Sam Harwell
///

public struct ATNDeserializationOptions {
    public static let defaultOptions: ATNDeserializationOptions = ATNDeserializationOptions()

    public var readOnly: Bool = false
    public var verifyATN: Bool
    public var generateRuleBypassTransitions: Bool

    public init() {
        self.verifyATN = true
        self.generateRuleBypassTransitions = false
    }

    public init(_ options: ATNDeserializationOptions) {
        self.verifyATN = options.verifyATN
        self.generateRuleBypassTransitions = options.generateRuleBypassTransitions
    }
}
