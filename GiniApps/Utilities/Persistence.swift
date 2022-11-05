//
//  Persistence.swift
//  GiniApps
//
//  Created by Aviram on 2/11/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//
//
//        do {
//            try viewContext.save()
//        } catch {
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: Constants.coreDataModelName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: Constants.coreDataURL)
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func fetchAllPhotos() -> [Photo]{
        print("fetchAllPhotos")
        let request : NSFetchRequest<Photo> = Photo.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Photo.likes, ascending: false)]
        
        do{
            return try viewContext.fetch(request)
        }catch {
            return []
        }
    }
    
    func fetchPhoto(photoId : Int) -> Photo? {
        print("fetchPhoto")
        let request : NSFetchRequest<Photo> = Photo.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %d", photoId)
        
        do{
            let result = try viewContext.fetch(request)
            return result.first
        }catch {
            return nil
        }
    }
    
}
