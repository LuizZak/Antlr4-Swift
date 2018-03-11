///
/// Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
/// Use of this file is governed by the BSD 3-clause license that
/// can be found in the LICENSE.txt file in the project root.
///

//
//  CharacterEextension.swift
//  Antlr.swift
//
//  Created by janyou on 15/9/4.
//

import Foundation

extension Character {

    public init(integerLiteral value: IntegerLiteralType) {
        self = Character(UnicodeScalar(value)!)
    }

    //"1" -> 1 "2"  -> 2
    var integerValue: Int {
        return Int(String(self)) ?? 0
    }

    var utf8Value: UInt8 {
        return String(self).utf8.first ?? 0
    }

    var utf16Value: UInt16 {
        return unicodeScalars.first?.utf16.first ?? 0
    }

    //char ->  int
    var unicodeValue: Int {
        return Int(self.unicodeScalars.first?.value ?? 0)
    }

    public static var maxValue: Int {
        let char: Character = "\u{10FFFF}"
        return char.unicodeValue
    }
    public static var minValue: Int {
        let char: Character = "\u{0000}"
        return char.unicodeValue
    }

    public static func isJavaIdentifierStart(_ char: Int) -> Bool {
        let char = Character(integerLiteral: char)
        return char == "_" || char == "$" || ("a" <= char && char <= "z") || ("A" <= char && char <= "Z")

    }

    public static func isJavaIdentifierPart(_ charLiteral: Int) -> Bool {
        let char = Character(integerLiteral: charLiteral)
        return isJavaIdentifierStart(charLiteral) || ("0" <= char && char <= "9")
    }

    public static func toCodePoint(_ high: Int, _ low: Int) -> Int {
        let minSupplementaryCodeUnit = 65536 // 0x010000
        let minHighSurrogate = 0xd800 //"\u{dbff}"  //"\u{DBFF}"  //"\u{DBFF}"
        let minLowSurrogate = 0xdc00 //"\u{dc00}" //"\u{DC00}"

        let highShiftedTenLow = ((high << 10) + low)
        let minHighSurrogateShifted = minHighSurrogate << 10

        return highShiftedTenLow + (minSupplementaryCodeUnit - minHighSurrogateShifted - minLowSurrogate)
    }

}
