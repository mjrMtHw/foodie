//
//  ReviewCell.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI

struct ReviewCell: View {
    
    @ObservedObject var review: Review
    
    var body: some View {
        HStack {
            StarView(model: StarViewVM(starRating: Double(review.starRating)))
            VStack() {
                Text(review.date?.foodieDate() ?? "no date")
                Text(review.notes ?? "no notes")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let review = Review(context: context)
        review.starRating = Int16(2)
        review.notes = "great place!"
        return ReviewCell(review: review)
    }
}
