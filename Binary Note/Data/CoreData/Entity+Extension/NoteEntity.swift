//
//  NoteEntity.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation

extension NoteEntity {
    
    static func toNote(entity: NoteEntity) -> NoteVO {
        
        return NoteVO(id: entity.id, title: entity.title, desc: entity.desc, date: entity.date)
        
    }
}
