//
//  CoreDataManager.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func getFetcheResultsController() -> NSFetchedResultsController<CRocketLaunch>
    func saveData()
    func removeData()
}

class CoreDataManager: NSObject, CoreDataManagerProtocol {
    static let sharedInstance : CoreDataManager = CoreDataManager()
    
    private let persistentContainer = NSPersistentContainer(name: "SpaceXApp")
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<CRocketLaunch> = {
        let fetchRequest: NSFetchRequest<CRocketLaunch> = CRocketLaunch.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "flightNumber", ascending: true)]

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
       
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    override init() {
        super.init()
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
                if let error = error {
                    print("Unable to Load Persistent Store")
                    print("\(error), \(error.localizedDescription)")

                }
            }
    }
    
    func getFetcheResultsController() -> NSFetchedResultsController<CRocketLaunch> {
        return self.fetchedResultsController
    }
    
    func saveData()  {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                try context.save()
            } catch {
                print("Error to save")
            }
        }
    }
    
    
    func removeData()  {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<CRocketLaunch> = CRocketLaunch.fetchRequest()
            
            do {
                let fetchedResults = try context.fetch(fetchRequest)
                
                for object in fetchedResults {
                    context.delete(object)
                }
                
                try context.save()
                
            } catch {
                print("Unable to Fetch Workouts, (\(error))")
            }
        }
    }
}

extension CoreDataManager : NSFetchedResultsControllerDelegate { }
