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
    
    func save(_ volume: Volume) {
        guard let context = getContext() else {return}
        
        let favoriteVolume = SavedVolume(context: context)
        favoriteVolume.setValue(volume, forKey: "volume")
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save session data! \(error): \(error.userInfo)")
        }
    }
    
    func remove(_ volume: Volume) {
        guard let context = getContext() else {return}
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVolume")
        do {
            let result = try context.fetch(request) as! [SavedVolume]
            result.forEach { requestedVolume in
                if volume.id == requestedVolume.volume?.id {
                    context.delete(requestedVolume)
                }
            }
            try context.save()

        } catch let error as NSError {
            print("Retrieving user failed. \(error): \(error.userInfo)")
        }
        
    }
    
    func retrieveSavedVolumes() -> [Volume] {
        guard let context = getContext() else {return []}
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedVolume")
        var volumes = [Volume]()
        do {
            let result = try context.fetch(request) as! [SavedVolume]
            volumes = result.compactMap({$0.volume})

        } catch let error as NSError {
            print("Retrieving user failed. \(error): \(error.userInfo)")
        }
        return volumes
    }
}
