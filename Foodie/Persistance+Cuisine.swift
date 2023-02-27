//
//  Persistance+Cuisine.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import Foundation
import CoreData

extension PersistenceController {
    
    func createCuisineIfNecessary() {
        self.fetchCuisines()
    }
    
    func fetchCuisines() {
        let fetchRequest: NSFetchRequest<Cuisine>
        fetchRequest = Cuisine.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Cuisine.name, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do  {
            let cuisines = try self.container.viewContext.fetch(fetchRequest)
            if (cuisines.count == 0) {
                self.createCuisines()
            }
        } catch {
            debugPrint("Error with fetch: \(error)")
            self.createCuisines()
        }
    }

    fileprivate func createCuisines() {
        let cuisines = ["bbq", "fish", "hamburger", "taco", "pizza", "coffee"]
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = self.container.viewContext
        backgroundContext.perform {
            for cuisine in cuisines {
                let added = Cuisine(context: backgroundContext)
                added.name = cuisine
                try? backgroundContext.save()
            }
        }
        
    }
}

