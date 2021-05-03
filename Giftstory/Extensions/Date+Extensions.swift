//
//  Date+Extensions.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

extension Date {
    
    /// Converts a Date object into a String of day/month/year format.
    func toStringSlashedDMY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    /// Converts a Date object into a String of year-month-day format.
    func toStringDashedYMD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter.string(from: self)
    }
    
    /// Converts a Date object into a String of ISO8601 format.
    func toISO601String() -> String {
        ISO8601DateFormatter().string(from: self)
    }
}
