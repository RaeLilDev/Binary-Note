//
//  NoteDetailViewController.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import UIKit
import RxSwift
import RxCocoa

class NoteDetailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var viewModel: NoteDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        
        viewModel.getNoteDetail()
        
        bindData()
        
    }
    
    private func setupNavbar() {
        self.navigationItem.title = "Detail"
        let btnEdit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(onTapEdit))
        self.navigationItem.rightBarButtonItems = [btnEdit]
    }
    
    private func bindData() {
        viewModel.noteDetailResult.subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            if let data = data {
                self.lblTitle.text = data.title
                self.lblDesc.text = data.desc
                self.lblDate.text = data.date?.toFormattedString()
            }
        }).disposed(by: disposeBag)
    }
    
    @objc private func onTapEdit() {
        navigateToEditNoteViewController(note: viewModel.getSelectedNote())
    }


    

}
