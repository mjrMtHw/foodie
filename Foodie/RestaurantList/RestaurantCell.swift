//
//  RestaurantCell.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI

struct RestaurantCell: View {
    @StateObject var model: RestaurantCellVM
    
    var body: some View {
        HStack {
            StarView(starRating: Review.averageStarRating(reviews:model.restaurant.reviews?.allObjects as? [Review] ?? []))
            VStack() {
                Text(model.restaurant.name ?? "")
                Text(model.restaurant.cuisineType?.name ?? "")
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            if (!model.isReviewScreen) {
                ZStack {
                    Circle()
                        .foregroundColor(Color.cyan)
                    Text("\(model.restaurant.reviews?.count ?? 0)")
                }
                    .frame(width: 40.0, height: 40.0, alignment: .trailing)
            }
        }
    }
}

//struct RestaurantCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantCell(model: RestaurantCellVM(restaurant: Restaurant()))
//    }
//}
