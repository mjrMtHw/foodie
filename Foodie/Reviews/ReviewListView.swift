//
//  ReviewListView.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI
import CoreData

struct ReviewListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var restaurant: FetchedResults<Restaurant>
    @State var isSheetPresented = false
    
    private func addReview() {
        isSheetPresented = true
    }
    
    
    var body: some View {
        List {
            if let thisRestaurant = restaurant.first {
                RestaurantCell(model: RestaurantCellVM(restaurant: thisRestaurant, isReviewScreen: true))
                ForEach(thisRestaurant.sortReviewsByDate(), id: \.self) { review in
                    ReviewCell(review: review)
                }
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Reviews")
            }
            ToolbarItem {
                Button(action: addReview) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            AddReviewView(restaurant: restaurant)
        }
    }
}


