//
//  NoteRepository.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import CoreData
import RxSwift
import RxCoreData

protocol NoteRepository {
    
    func saveNote(data: NoteVO)
    
    func getNotes() -> Observable<[NoteVO]>
    
    func getNoteDetail(id: String) -> Observable<NoteVO?>
    
    func deleteNote(data: NoteVO)
    
}

class NoteRepositoryImpl: BaseRepository, NoteRepository {
    
    static let shared: NoteRepository = NoteRepositoryImpl()
    
    private override init() { }
    
    func saveNote(data: NoteVO) {
        let _ = data.toNoteEntity(context: self.coreData.context)
        self.coreData.saveContext()
    }
    
    func deleteNote(data: NoteVO) {
        
        let fetchRequest = getNoteFetchRequestById(id: data.id ?? "")
        do {
            let results = try coreData.context.fetch(fetchRequest)

            for result in results {
                coreData.context.delete(result)
            }
        } catch _ {
            debugPrint("Error deletion")
        }
        self.coreData.saveContext()
        
    }
    
    
    
    func getNotes() -> Observable<[NoteVO]> {
        
        let fetchRequest: NSFetchRequest<NoteEntity> = getNotesFetchRequestByDate()

        return coreData.context.rx.entities(fetchRequest: fetchRequest)
            .map { data -> [NoteVO] in
                if data.count > 0 {
                    return data.map { NoteEntity.toNote(entity: $0) }
                } else {
                    return [NoteVO]()
                }
            }
    }
    
    
    func getNoteDetail(id: String) -> Observable<NoteVO?> {
        let fetchRequest = getNoteFetchRequestById(id: id)
        return coreData.context.rx.entities(fetchRequest: fetchRequest)
            .map { data -> NoteVO? in
                if let item = data.first {
                    return NoteEntity.toNote(entity: item)
                }
                return nil
            }
    }

    
    

    private func getNotesFetchRequestByDate() -> NSFetchRequest<NoteEntity> {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        return fetchRequest
    }
    
    private func getNoteFetchRequestById(id: String) -> NSFetchRequest<NoteEntity> {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", "\(id)")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        return fetchRequest
    }

}
