///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

public struct TuplePair<T: Hashable, U: Hashable>: Hashable {
    public var key1: T
    public var key2: U
    
    public init(_ key1: T, _ key2: U) {
        self.key1 = key1
        self.key2 = key2
    }
}
