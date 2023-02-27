//
//  ReviewCell.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI

struct ReviewCell: View {
    
    var review: Review
    
    var body: some View {
        HStack {
            StarView(starRating: Double(review.starRating))
            VStack() {
                Text(review.date?.foodieDate() ?? "no date")
                Text(review.notes ?? "no notes")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//struct ReviewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewCell(review: Review())
//    }
//}
