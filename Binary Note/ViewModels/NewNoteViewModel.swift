//
//  NewNoteViewModel.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import RxSwift

class NewNoteViewModel {
    
    private var noteModel: NoteModel!
    
    let titleSubject = PublishSubject<String>()
    let descSubject = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    private var titleStr = ""
    private var descriptionStr = ""
    
    init(noteModel: NoteModel) {
        self.noteModel = noteModel
    }
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(titleSubject.asObservable().startWith(""), descSubject.asObservable().startWith(""))
            .map { title, desc -> Bool in
                self.titleStr = title
                self.descriptionStr = desc
                return !title.isEmpty && !desc.isEmpty
            }.startWith(false)
    }
    
    func saveNote() {
        self.noteModel.saveNote(data: self.getNoteObject(title: titleStr, desc: descriptionStr))
    }
    
    
    func getNoteObject(title: String, desc: String) -> NoteVO {
        var object = NoteVO()
        object.id = UUID().uuidString
        object.title = title
        object.desc = desc
        object.date = Date()
        return object
    }
    
    
    
}
