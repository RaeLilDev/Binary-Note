//
//  Route+Extension.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func navigateToNoteDetailViewController(id: String) {
        let vc = NoteDetailViewController()
        vc.viewModel = NoteDetailViewModel(noteId: id, noteModel: NoteModelImpl.shared)
        self.navigationItem.backButtonTitle = "Back"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func navigateToNewNoteViewController() {
        let vc = NewNoteViewController()
        vc.viewModel = NewNoteViewModel(noteModel: NoteModelImpl.shared)
        self.navigationItem.backButtonTitle = "Back"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToEditNoteViewController(note: NoteVO) {
        let vc = EditNoteViewController()
        vc.viewModel = EditNoteViewModel(noteModel: NoteModelImpl.shared, selectedNote: note)
        self.navigationItem.backButtonTitle = "Back"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
