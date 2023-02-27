//
//  Date+Format.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Foundation

extension Date {
    func foodieDate() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEE MMM d yyyy")
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
}
