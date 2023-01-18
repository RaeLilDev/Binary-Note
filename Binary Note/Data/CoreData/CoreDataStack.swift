//
//  CoreDataStack.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    static let shared = CoreDataStack()
    
    var persistentContainer = NSPersistentContainer(name: "BinaryNote")
    
    var context: NSManagedObjectContext {
        get {
            persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            return persistentContainer.viewContext
        }
    }
    
    private override init() {
        persistentContainer = NSPersistentContainer(name: "BinaryNote")
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
    
    func saveContext() {
        let context = self.context
        if context.hasChanges {
            do {
                try context.save()
                debugPrint("Save is occured")
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
