///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

///
/// An immutable inclusive interval a..b
///

public struct Interval: Hashable {
    public static let invalid: Interval = Interval(-1, -2)

    public var a: Int
    public var b: Int

    public static var creates: Int = 0
    public static var misses: Int = 0
    public static var hits: Int = 0
    public static var outOfRange: Int = 0

    public init(_ start: Int, _ end: Int) {
        self.a = start
        self.b = end
    }

    ///
    /// Interval objects are used readonly so share all with the
    /// same single value a==b up to some max size.  Use an array as a perfect hash.
    /// Return shared object for 0..INTERVAL_POOL_MAX_VALUE or a new
    /// Interval object with a..a in it.  On Java.g4, 218623 IntervalSets
    /// have a..a (set with 1 element).
    ///
    public static func of(_ start: Int, _ end: Int) -> Interval {
        return Interval(start, end)
    }

    ///
    /// return number of elements between a and b inclusively. x..x is length 1.
    /// if b &lt; a, then length is 0.  9..10 has length 2.
    ///
    public func length() -> Int {
        if b < a {
            return 0
        }
        return b - a + 1
    }

    public var hashValue: Int {
        var hash: Int = 23
        hash = hash * 31 + a
        hash = hash * 31 + b
        return hash
    }
    ///
    /// Does this start completely before a? Disjoint
    ///
    public func startsBeforeDisjoint(_ a: Interval) -> Bool {
        return self.a < a.a && self.b < a.a
    }

    ///
    /// Does this start at or before a? Nondisjoint
    ///
    public func startsBeforeNonDisjoint(_ a: Interval) -> Bool {
        return self.a <= a.a && self.b >= a.a
    }

    ///
    /// Does this.a start after a.b? May or may not be disjoint
    ///
    public func startsAfter(_ a: Interval) -> Bool {
        return self.a > a.a
    }

    ///
    /// Does this start completely after a? Disjoint
    ///
    public func startsAfterDisjoint(_ a: Interval) -> Bool {
        return self.a > a.b
    }

    ///
    /// Does this start after a? NonDisjoint
    ///
    public func startsAfterNonDisjoint(_ a: Interval) -> Bool {
        return self.a > a.a && self.a <= a.b // this.b>=a.b implied
    }

    ///
    /// Are both ranges disjoint? I.e., no overlap?
    ///
    public func disjoint(_ a: Interval) -> Bool {
        return startsBeforeDisjoint(a) || startsAfterDisjoint(a)
    }

    ///
    /// Are two intervals adjacent such as 0..41 and 42..42?
    ///
    public func adjacent(_ a: Interval) -> Bool {
        return self.a == a.b + 1 || self.b == a.a - 1
    }

    public func properlyContains(_ a: Interval) -> Bool {
        return a.a >= self.a && a.b <= self.b
    }

    ///
    /// Return the interval computed from combining this and a
    ///
    public func union(_ other: Interval) -> Interval {
        return Interval.of(min(a, other.a), max(b, other.b))
    }

    ///
    /// Return the interval in common between this and o
    ///
    public func intersection(_ other: Interval) -> Interval {
        return Interval.of(max(a, other.a), min(b, other.b))
    }

    ///
    /// Return the interval with elements from this not in a;
    /// a must not be totally enclosed (properly contained)
    /// within this, which would result in two disjoint intervals
    /// instead of the single one returned by this method.
    ///
    public func differenceNotProperlyContained(_ a: Interval) -> Interval? {
        var diff: Interval? = nil
        // a.a to left of this.a (or same)
        if a.startsBeforeNonDisjoint(self) {
            diff = Interval.of(max(self.a, a.b + 1), self.b)
        } else {
            if a.startsAfterNonDisjoint(self) {
                diff = Interval.of(self.a, a.a - 1)
            }
        }
        return diff
    }

    public var description: String {
        return "\(a)..\(b)"
    }

    public static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b
    }
}
