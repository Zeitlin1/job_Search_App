//
//  CoreDataStack.swift
//  job_Search_App
//
//  Created by Anthony on 12/23/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()
    
    private static let name = "job_Search_App"
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: CoreDataStack.name)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    func deleteLead(deleteTarget: String) {
     
        let fetchRequest = NSFetchRequest<Lead>(entityName: "Lead")
        
        if let result = try? context.fetch(fetchRequest) {
            
            for lead in result {
                // if Lead's name or other id matches current Lead then delete it.
                
                if lead.name == deleteTarget {
                
                context.delete(lead)
                
                    print("Deleted Lead")
                }
            }
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Error occured during save: \(error) \(error.localizedDescription)")
            }
        }

    }
    
    func retrieveNotes(notesTarget: Business) {
        let fetchRequest = NSFetchRequest<Lead>(entityName: "Lead")
        
        if let result = try? context.fetch(fetchRequest) {
            
            for lead in result {
                
                if lead.name == notesTarget.name {
                    
                    lead.notes = notesTarget.notes
                    
                }
            }
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Error occured during save: \(error) \(error.localizedDescription)")
            }
        }
        
    }

    
}
