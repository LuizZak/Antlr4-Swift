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

public enum LookupDictionaryType: Int {
    case lookup = 0
    case ordered
}

public struct LookupDictionary<T: ATNConfig> {
    @usableFromInline
    private(set) internal var type: LookupDictionaryType
    
    @usableFromInline
    internal var cache: [Int: T] = [:]
    
    public var isEmpty: Bool {
        return cache.isEmpty
    }
    
    public init(type: LookupDictionaryType = LookupDictionaryType.lookup) {
        self.type = type
    }
    
    @usableFromInline
    func hash(_ config: T) -> Int {
        if type == LookupDictionaryType.lookup {
            var hash = Hasher()
            hash.combine(config.state.stateNumber)
            hash.combine(config.alt)
            hash.combine(config.semanticContext)
            return hash.finalize()
        } else {
            //Ordered
            return config.hashValue
        }
    }
    
    @inlinable
    public mutating func getOrAdd(_ config: T) -> (added: Bool, T) {
        let h = hash(config)

        if let configList = cache[h] {
            return (false, configList)
        } else {
            cache[h] = config
        }

        return (true, config)
    }
    
    @usableFromInline
    mutating func update(_ config: T) {
        let h = hash(config)
        cache[h] = config
    }
    
    @inlinable
    public func contains(_ config: T) -> Bool {
        let h = hash(config)
        return cache[h] != nil
    }
    
    public mutating func removeAll() {
        cache = [:]
    }
}
