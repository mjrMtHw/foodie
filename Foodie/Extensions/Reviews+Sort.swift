//
//  Reviews+Sort.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Foundation

extension Review {
    class func averageStarRating(reviews: [Review]) -> Double {
        let ratings = reviews.map { $0.starRating }
        let sumRatings = ratings.reduce(.zero, +)
        if reviews.count > 0 {
            return Double(sumRatings) / Double(reviews.count)
        } else {
            return 0
        }
    }
    
    class func reviewArray(nsSet: NSSet?) -> [Review] {
        if let array = nsSet?.allObjects as? [Review] {
            return array
        } else {
            return []
        }
    }
    
    class func mostRecentReview(nsSet: NSSet?) -> Date {
        let date_default = Date(timeIntervalSince1970: 0)
        if let array = nsSet?.allObjects as? [Review] {
            let maxdate = array.max(by: { (a, b) -> Bool in
                return a.date ?? date_default < b.date ?? date_default
            })

            return maxdate?.date ?? date_default
        }
        
        return date_default
    }
}
