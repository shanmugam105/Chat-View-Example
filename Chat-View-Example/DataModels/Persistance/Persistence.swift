//
//  Persistence.swift
//  WinkWallet
//
//  Created by Mac on 13/05/22.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ChatDataModel")
        container.persistentStoreDescriptions.first?.setOption(FileProtectionType.complete as NSObject,
                                                               forKey: NSPersistentStoreFileProtectionKey)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    @discardableResult
    func save() -> Bool {
        do {
            try container.viewContext.save()
            return true
        } catch {
            return false
        }
    }
}
