//
//  Persistence+Extension.swift
//  WinkWallet
//
//  Created by Mac on 02/06/22.
//

import Foundation
import CoreData

extension PersistenceController {
    func saveNewMessage(id: String?, date: String?, message: String, toId: Int64, fromId: Int64) {
        let messageEntity = MessageEntity(context: container.viewContext)
        messageEntity.id      = id
        messageEntity.date    = date
        messageEntity.message = message
        messageEntity.toId    = toId
        messageEntity.fromId  = fromId
        save()
    }
    
    func fetchAllMessage() -> [MessageEntity] {
        let fetchRequest: NSFetchRequest = MessageEntity.fetchRequest()
        let result = try? container.viewContext.fetch(fetchRequest)
        return result ?? []
    }
}
