//
//  CoreDataStack.swift
//  Flashcards
//
//  Created by Shikha Sharma on 5/30/24.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Flashcards")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

