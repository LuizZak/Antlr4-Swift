/// 
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

public struct MultiMap<K:Hashable, V> {
    private var mapping = [K: [V]]()

    public mutating func map(_ key: K, _ value: V) {
        mapping[key, default: []].append(value)
    }

    public func getPairs() -> [(K, V)] {
        var pairs: [(K, V)] = [(K, V)]()
        for key: K in mapping.keys {
            for value: V in mapping[key]! {
                pairs.append((key, value))
            }
        }
        return pairs
    }

    public func get(_ key: K) -> Array<(V)>? {
        return mapping[key]
    }

    public func size() -> Int {
        return mapping.count
    }

}
