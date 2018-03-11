///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

import Foundation

//https://github.com/pNre/ExSwift/blob/master/ExSwift/Array.swift
extension Array {
    func all(_ predicate: (Element) -> Bool) -> Bool {
        for item in self {
            if !predicate(item) {
                return false
            }
        }

        return true
    }

    ///
    /// Checks if test returns true for all the elements in self
    ///
    /// :param: test Function to call for each element
    /// :returns: True if test returns true for all the elements in self
    ///
    func every(_ predicate: (Element) -> Bool) -> Bool {
        for item in self {
            if !predicate(item) {
                return false
            }
        }

        return true
    }

    ///
    /// Checks if test returns true for any element of self.
    ///
    /// :param: test Function to call for each element
    /// :returns: true if test returns true for any element of self
    ///
    func any(_ predicate: (Element) -> Bool) -> Bool {
        for item in self {
            if predicate(item) {
                return true
            }
        }

        return false
    }

    func slice(_ index: Int, isClose: Bool = false) -> (first: ArraySlice<Element>, second: ArraySlice<Element>) {
        var first = self[...index]
        var second = self[index..<count]

        if isClose {
            first = second + first
            second = []
        }

        return (first, second)
    }
}

extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        var index: Int?
        for (idx, objectToCompare) in self.enumerated() where object == objectToCompare {
            index = idx
        }

        if let index = index {
            self.remove(at: index)
        }
    }
}
