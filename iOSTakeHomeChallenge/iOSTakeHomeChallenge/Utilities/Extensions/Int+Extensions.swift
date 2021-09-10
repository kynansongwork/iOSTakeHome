//
//  Int+Extensions.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 10/09/2021.
//

import Foundation

//https://stackoverflow.com/questions/36068104/convert-integer-to-roman-numeral-string-in-swift
extension Int {
    var romanNumeral: String {
        var integerValue = self
        var numeralString = ""
        let mappingList: [(Int, String)] = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        for i in mappingList {
            while (integerValue >= i.0) {
                integerValue -= i.0
                numeralString += i.1
            }
        }
        return numeralString
    }
}
