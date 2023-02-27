//
//  MainView.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI
import CoreData

enum RestaurantFilters: String, CaseIterable {
    case name = "Name"
    case stars = "Avg Rating"
    case time = "Most Recent"
}

class ReviewListVM: ObservableObject {
    
    @Published var isSheetPresented = false
    @Published var filter: RestaurantFilters = .name
    @State var reload: Bool = false
    
    func sortedByFilter(restaurants: FetchedResults<Restaurant>) -> [Restaurant] {
        switch self.filter {
        case .name:
            return Restaurant.sortByName(restaurants: restaurants)
        case .stars:
            return Restaurant.sortByAvgReview(restaurants: restaurants)
        case .time:
            return Restaurant.sortByMostRecentReview(restaurants: restaurants)
        }
    }
}

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Restaurant.name, ascending: true)],
        animation: .default)
    private var restaurants: FetchedResults<Restaurant>
    
    @StateObject var model: ReviewListVM = ReviewListVM()

    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort by:", selection: $model.filter) {
                    ForEach(RestaurantFilters.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                List {
                    ForEach(model.sortedByFilter(restaurants: restaurants)) { restaurant in
                        NavigationLink {
                            ReviewListView(restaurant: FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "identifier == %@", restaurant.identifier!)))
                        } label: {
                            RestaurantCell(model: RestaurantCellVM(restaurant: restaurant, isReviewScreen: false))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Foodie")
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSPersistentStoreRemoteChange), perform: { output in
            //FIXME: update the view here?
        }
        )
        .sheet(isPresented: $model.isSheetPresented) {
            AddRestaurantsView()
        }

    }

    private func addItem() {
        model.isSheetPresented = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { model.sortedByFilter(restaurants: restaurants)[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
