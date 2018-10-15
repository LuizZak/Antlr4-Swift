///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

//
//  LookupDictionary.swift
//   antlr.swift
//
//  Created by janyou on 15/9/23.
//

import Foundation

@usableFromInline
internal struct LookupDictionary<T> {
    @usableFromInline
    var cache: [Int: (Int, T)] = [:]
    
    @usableFromInline
    var hash: (T) -> Int
    
    public var isEmpty: Bool {
        return cache.isEmpty
    }
    
    init(hash: @escaping (T) -> Int) {
        self.hash = hash
    }
    
    @inlinable
    public mutating func getOrAdd(_ config: T, index: Int) -> (added: Bool, T) {

        let h = hash(config)

        if let configList = cache[h] {
            return (false, configList.1)
        } else {
            cache[h] = (index, config)
        }

        return (true, config)
    }
    
    @usableFromInline
    mutating func update(_ config: T) -> Int? {
        
        let h = hash(config)
        
        if cache.keys.contains(h) {
            cache[h]?.1 = config
            return cache[h]?.0
        }
        
        return nil
    }
    
    @inlinable
    public func contains(_ config: T) -> Bool {
        let h = hash(config)
        return cache.keys.contains(h)

    }
    
    @inlinable
    public mutating func removeAll() {
        cache = [:]
    }

}
