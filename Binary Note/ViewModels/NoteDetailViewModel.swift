//
//  NoteDetailViewModel.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import RxSwift
import RxCocoa

class NoteDetailViewModel {
    private let disposeBag = DisposeBag()
    
    private var noteId: String!
    private var noteModel: NoteModel!
    
    let noteDetailResult: BehaviorSubject<NoteVO?> = BehaviorSubject(value: nil)
    
    private var selectedNote: NoteVO!
    
    init(noteId: String, noteModel: NoteModel) {
        self.noteId = noteId
        self.noteModel = noteModel
    }
    
    func getNoteDetail() {
        noteModel.getNoteById(id: noteId)
            .subscribe(onNext: { data in
                self.selectedNote = data
                self.noteDetailResult.onNext(data)
            }).disposed(by: disposeBag)
    }
    
    func getSelectedNote() -> NoteVO {
        selectedNote
    }
    
    
}
