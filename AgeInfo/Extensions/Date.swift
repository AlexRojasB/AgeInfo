//
//  Date.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//

import Foundation

extension Date {
    
    static func from(year: Int, month: Int, day: Int) -> Date? {
         let calendar = Calendar(identifier: .gregorian)
         var dateComponents = DateComponents()
         dateComponents.year = year
         dateComponents.month = month
         dateComponents.day = day
         return calendar.date(from: dateComponents) ?? nil
     }

    var year: String {
        get {
            let calendar = Calendar.current
            return String(calendar.component(.year, from: self))
        }
    }
    
    var zodiacSign: ZodiacSign {
        get {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: self)
            let month = calendar.component(.month, from: self)

            switch (day, month) {
            case (21...31, 1), (1...19, 2):
                return .Aquarius
            case (20...29, 2), (1...20, 3):
                return .Pisces
            case (21...31, 3), (1...20, 4):
                return .Aries
            case (21...30, 4), (1...21, 5):
                return .Taurus
            case (22...31, 5), (1...21, 6):
                return .Gemini
            case (22...30, 6), (1...22, 7):
                return .Cancer
            case (23...31, 7), (1...22, 8):
                return .Leo
            case (23...31, 8), (1...23, 9):
                return .Virgo
            case (24...30, 9), (1...23, 10):
                return .Libra
            case (24...31, 10), (1...22, 11):
                return .Scorpio
            case (23...30, 11), (1...21, 12):
                return .Sagittarius
            default:
                return .Capricorn
            }
        }
    }
    
    var GenerationIndex: Int {
        get {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: self)

            switch (year) {
            case (1926...1945):
                return 0
            case (1946...1964):
                return 1
            case (1965...1980):
                return 2
            case (1981...1995):
                return 3
            case (1996...2010):
                return 4
            case (2011...2026):
                return 5
            default:
                return 0
            }
        }
    }

}

enum ZodiacSign: String {
    case Aries
    case Taurus
    case Gemini
    case Cancer
    case Leo
    case Virgo
    case Libra
    case Scorpio
    case Sagittarius
    case Capricorn
    case Aquarius
    case Pisces
}
