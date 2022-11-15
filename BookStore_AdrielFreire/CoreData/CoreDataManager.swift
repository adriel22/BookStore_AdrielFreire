//
//  CoreDataManager.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import CoreData
import UIKit

final class CoreDataManager: NSObject {
    private override init() {

    }
    public static var shared = CoreDataManager()
    
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(_ id: String) {
        guard let context = getContext() else {return}
        
        let favoriteVolume = SavedVolume(context: context)
        favoriteVolume.setValue(id, forKey: "id")
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save session data! \(error): \(error.userInfo)")
        }
    }
    
    func remove(_ id: String) {
        guard let context = getContext() else {return}
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVolume")
        do {
            let result = try context.fetch(request) as! [SavedVolume]
            result.forEach { volume in
                if volume.id == id {
                    context.delete(volume)
                }
            }
            try context.save()

        } catch let error as NSError {
            print("Retrieving user failed. \(error): \(error.userInfo)")
        }
        
    }
    
    func retrieveSavedIDs() -> [String] {
        guard let context = getContext() else {return []}
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVolume")
        var ids = [String]()
        do {
            let result = try context.fetch(request) as! [SavedVolume]
            ids = result.map({$0.id ?? ""})

        } catch let error as NSError {
            print("Retrieving user failed. \(error): \(error.userInfo)")
        }
        return ids
    }
}
