//
//  NoteVO.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import CoreData

struct NoteVO {
    var id: String?
    var title: String?
    var desc: String?
    var date: Date?
    
    
    @discardableResult
    func toNoteEntity(context: NSManagedObjectContext) -> NoteEntity {
        let entity = NoteEntity(context: context)
        entity.id = self.id
        entity.title = self.title
        entity.desc = self.desc
        entity.date = self.date
        return entity
    }
    
}
