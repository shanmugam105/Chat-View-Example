//
//  String+Extension.swift
//  Chat-View-Example
//
//  Created by Sparkout on 24/10/22.
//

import Foundation

extension Date {
    // MARK:- Extension for converting Date to String
    
    func toString(format: String, timeZone: TimeZone = .current) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        df.timeZone = timeZone
        return df.string(from: self)
    }
}

extension String {
    var asURL: URL {
        return URL(string: self)!
    }

    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: utf16.count)) ?? 0
    }
    
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }
}
