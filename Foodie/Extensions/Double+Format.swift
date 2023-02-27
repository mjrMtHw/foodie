//
//  Double+Format.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Foundation

extension Double {
    func limit1SigFig() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let value = formatter.string(from: NSNumber(value: self))
        return value
    }
    
    
}
