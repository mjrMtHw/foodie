//
//  Cuisine+Sorted.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Foundation
import SwiftUI

extension Cuisine {
    class func sortedToArray(cuisineTypes: FetchedResults<Cuisine>) -> [Cuisine] {

        return Array(cuisineTypes)
    }
}
