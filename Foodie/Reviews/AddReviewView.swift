//
//  AddReviewView.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI
import CoreData

struct AddReviewView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State var restaurant: FetchedResults<Restaurant>
    @StateObject var model = AddReviewVM()
    
    
    private func addReview() {

        let newReview = Review(context: viewContext)
        newReview.starRating = Int16(model.starRating)
        newReview.notes = model.notes
        newReview.restaurant = restaurant.first
        newReview.date = model.date
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            debugPrint("error saving")
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Add review")
                .padding()
            Form {
                DatePicker(selection: $model.date) {
                    Text("Select the date you visited")
                }
                Picker("Rate your visit", selection: $model.starRating) {
                    ForEach(model.ratings, id: \.self)  { num in
                        Text("\(model.ratings[num - 1])").tag(num)
                    }
                }
                Section("Enter your review") {
                    TextEditor(text: $model.notes)
                        .frame(minHeight: 60.0)
                }
            }
            Button(action: addReview) {
                Text("Save")
            }
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

//FIXME: can't preview
//struct AddReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        let context  = PersistenceController.shared.container.viewContext
//        let restaurant = Restaurant(context: context)
//        restaurant.name = "Boise Fry Company"
//        return AddReviewView(restaurant: restaurant).environment(\.managedObjectContext, context)
//    }
//}
