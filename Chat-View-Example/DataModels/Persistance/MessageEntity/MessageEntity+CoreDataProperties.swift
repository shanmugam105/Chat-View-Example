//
//  MessageEntity+CoreDataProperties.swift
//  Chat-View-Example
//
//  Created by Sparkout on 22/10/22.
//
//

import Foundation
import CoreData


extension MessageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageEntity> {
        return NSFetchRequest<MessageEntity>(entityName: "MessageEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: String?
    @NSManaged public var message: String?
    @NSManaged public var toId: Int64
    @NSManaged public var fromId: Int64

}
