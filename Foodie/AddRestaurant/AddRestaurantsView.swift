//
//  AddRestaurantsView.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI

class AddRestaurantViewModel: ObservableObject {
    @Published var name = ""
    @Published var selectedCuisine: String = "coffee"
    
    func cuisineArray(_ cuisines: FetchedResults<Cuisine>) -> [Cuisine] {
        return Cuisine.sortedToArray(cuisineTypes: cuisines)
    }
    func namesOf(_ cuisines: FetchedResults<Cuisine>) -> [String] {
        let array = self.cuisineArray(cuisines)
        return array.compactMap {
            $0.name
        }
    }
    func cuisineFor(name: String, cuisines: FetchedResults<Cuisine>) -> Cuisine? {
        for cuisine in cuisines {
            if cuisine.name == name {
                return cuisine
            }
        }
        return nil
    }
}

struct AddRestaurantsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var cuisineTypes: FetchedResults<Cuisine>
    @StateObject var model = AddRestaurantViewModel()
    
    private func addItem() {

        let newRestaurant = Restaurant(context: viewContext)
        newRestaurant.identifier = UUID().uuidString
        newRestaurant.name = model.name
        newRestaurant.cuisineType = model.cuisineFor(name: model.selectedCuisine, cuisines: cuisineTypes)
        
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
            Text(NSLocalizedString("Add restaurant", comment: ""))
                .padding()
            Form() {
                TextField(NSLocalizedString("Name:", comment: ""), text: $model.name)
                Picker(selection: $model.selectedCuisine) {
                    ForEach(model.namesOf(cuisineTypes), id: \.self) { cuisine in
                        Text(cuisine)
                    }
                } label: {
                    Text("Cuisine: \(model.selectedCuisine)")
                }
            }
            Button(action: addItem) {
                Text("Save")
            }
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

struct AddRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantsView()
    }
}
