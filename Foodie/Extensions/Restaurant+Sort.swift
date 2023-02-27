//
//  Restaurant+Sort.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Foundation
import SwiftUI

extension Restaurant {
    func sortReviewsByDate() -> [Review] {
        if let reviews = self.reviews as? Set<Review> {
            let sorted = reviews.sorted {
                $0.date ?? Date() > $1.date ?? Date()
            }
            return sorted
        }
        return []
        
    }
    
    class func sortByName(restaurants: FetchedResults<Restaurant>) -> [Restaurant] {
        let sorted = restaurants.sorted {
            $0.name ?? "z" < $1.name ?? "z"
        }
        return sorted
    }
    
    class func sortByAvgReview(restaurants: FetchedResults<Restaurant>) -> [Restaurant] {

        let sorted = restaurants.sorted {
            Review.averageStarRating(reviews: Review.reviewArray(nsSet: $0.reviews)) > Review.averageStarRating(reviews: Review.reviewArray(nsSet: $1.reviews))
        }
        return sorted
    }
    
    class func sortByMostRecentReview(restaurants: FetchedResults<Restaurant>) -> [Restaurant] {
        let sorted = restaurants.sorted {
            Review.mostRecentReview(nsSet: $0.reviews) >
            Review.mostRecentReview(nsSet: $1.reviews)
        }
        
        
        return sorted
    }
}
