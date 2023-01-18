//
//  EditNoteViewModel.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import RxSwift

class EditNoteViewModel {
    
    private var noteModel: NoteModel!
    
    let titleSubject = PublishSubject<String>()
    let descSubject = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    private var selectedNote: NoteVO!
    
    init(noteModel: NoteModel, selectedNote: NoteVO) {
        self.noteModel = noteModel
        self.selectedNote = selectedNote
    }
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(titleSubject.asObservable().startWith(selectedNote.title ?? ""), descSubject.asObservable().startWith(selectedNote.desc ?? ""))
            .map { !$0.isEmpty && !$1.isEmpty }.startWith(false)
    }
    
    func saveNote(title: String, desc: String) {
        self.noteModel.saveNote(data: self.getNoteObject(title: title, desc: desc))
    }
    
    func getSelectedNote() -> NoteVO {
        return selectedNote
    }
    
    func getNoteObject(title: String, desc: String) -> NoteVO {
        var object = NoteVO()
        object.id = selectedNote.id ?? ""
        object.title = title
        object.desc = desc
        object.date = Date()
        return object
    }
    
    
    
}
