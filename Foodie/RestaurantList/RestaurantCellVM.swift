//
//  RestaurantCellVM.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Combine

class RestaurantCellVM: ObservableObject {

    @Published var restaurant: Restaurant
    @Published var isReviewScreen: Bool
    
    init(restaurant: Restaurant, isReviewScreen: Bool = false) {
        self.restaurant = restaurant
        self.isReviewScreen = isReviewScreen
    }
}


