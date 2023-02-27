//
//  AddReviewVM.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Combine
import Foundation

class AddReviewVM: ObservableObject {
    @Published var date = Date()
    @Published var notes : String = ""
    @Published var starRating: Int = 3
    
    let ratings = [1,2,3,4,5]
}
