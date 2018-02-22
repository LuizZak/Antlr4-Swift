///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

public struct TuplePair<T: Hashable, U: Hashable>: Hashable {
    public var key1: T
    public var key2: U

    public var hashValue: Int {
        var hash = 3
        hash = hash * 17 + key1.hashValue
        hash = hash * 17 + key2.hashValue
        return hash
    }

    public init(_ key1: T, _ key2: U) {
        self.key1 = key1
        self.key2 = key2
    }

    public static func ==(lhs: TuplePair, rhs: TuplePair) -> Bool {
        return lhs.key1 == rhs.key1 && lhs.key2 == rhs.key2
    }
}
