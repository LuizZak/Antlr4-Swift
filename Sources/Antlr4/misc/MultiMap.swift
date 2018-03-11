///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///
public class MultiMap<K: Hashable, V> {

    private var mapping = [K: [V]]()

    public func map(_ key: K, _ value: V) {
        mapping[key, default: []].append(value)
    }

    public func getPairs() -> [(K, V)] {
        return mapping.flatMap { key, values in
            return values.map { v in
                (key, v)
            }
        }
    }

    public func get(_ key: K) -> [V]? {
        return mapping[key]
    }

    public func size() -> Int {
        return mapping.count
    }
}
