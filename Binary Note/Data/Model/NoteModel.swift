//
//  NoteModel.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import RxSwift

protocol NoteModel {
    
    func saveNote(data: NoteVO)
    
    func getNoteList() -> Observable<[NoteVO]>
    
    func getNoteById(id: String) -> Observable<NoteVO?>
    
    func deleteNote(data: NoteVO)
    
}

class NoteModelImpl: NoteModel {
    
    private let noteRepository: NoteRepository = NoteRepositoryImpl.shared
    
    static let shared = NoteModelImpl()
    
    let disposeBag = DisposeBag()
    
    func saveNote(data: NoteVO) {
        noteRepository.saveNote(data: data)
    }
    
    
    func getNoteList() -> Observable<[NoteVO]> {
        return noteRepository.getNotes()
    }
    
    func getNoteById(id: String) -> Observable<NoteVO?> {
        return noteRepository.getNoteDetail(id: id)
    }
    
    func deleteNote(data: NoteVO) {
        return noteRepository.deleteNote(data: data)
    }
    
}
