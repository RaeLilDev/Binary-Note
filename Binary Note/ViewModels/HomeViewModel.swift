//
//  HomeViewModel.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import RxSwift
import RxCocoa


class HomeViewModel {
    
    let noteList = BehaviorRelay<[NoteVO]>(value: [])
    
    var noteModel: NoteModel!
    
    private let disposeBag = DisposeBag()
    
    init(noteModel: NoteModel) {
        self.noteModel = noteModel
        
        fetchAllNotes()
    }
    
    
    func fetchAllNotes() {
        noteModel.getNoteList()
            .subscribe(onNext: { [weak self] data in
                debugPrint(data)
                guard let self = self else { return }
                self.noteList.accept(data)
            }).disposed(by: disposeBag)
    }
    
    func deleteNote(by index: Int) {
        let note = getNote(by: index)
        noteModel.deleteNote(data: note)
    }
    
    func getNoteCount() -> Int {
        noteList.value.count
    }
    
    func getNote(by index: Int) -> NoteVO {
        return noteList.value[index]
    }
    
    func getNoteId(by index: Int) -> String {
        return noteList.value[index].id ?? ""
    }
    
    
    
}
