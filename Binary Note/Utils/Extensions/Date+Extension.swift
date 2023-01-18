//
//  Date+Extension.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation

extension Date {
    
    func toFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "dd-MMM-yyyy hh:mm a"
        let date = formatter.string(from: self)
        return date
    }
}

