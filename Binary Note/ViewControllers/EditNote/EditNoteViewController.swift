//
//  EditNoteViewController.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import UIKit
import RxSwift
import RxCocoa

class EditNoteViewController: UIViewController {
    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtViewDesc: UITextView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: EditNoteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        
        setupView()
        
        bindInputFields()
    }
    
    private func setupView() {
        bindData()
        
        txtViewDesc.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 12)
        txtViewDesc.layer.borderWidth = 0.5
        txtViewDesc.layer.borderColor = UIColor(named: "colorPrimary")?.cgColor
        txtViewDesc.layer.cornerRadius = 12.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 5))
        txtFieldTitle.leftViewMode = .always
        txtFieldTitle.leftView = paddingView
        txtFieldTitle.layer.borderWidth = 0.5
        txtFieldTitle.layer.borderColor = UIColor(named: "colorPrimary")?.cgColor
        txtFieldTitle.layer.cornerRadius = 12.0
    }
    
    private func bindData() {
        let data = viewModel.getSelectedNote()
        txtFieldTitle.text = data.title
        txtViewDesc.text = data.desc
    }
    
    private func bindInputFields() {
        
        txtFieldTitle.rx.text.map{ $0 ?? ""}.bind(to: viewModel.titleSubject).disposed(by: disposeBag)
        txtViewDesc.rx.text.map { $0 ?? ""}.bind(to: viewModel.descSubject).disposed(by: disposeBag)
        
        viewModel.isValid().subscribe(onNext: { valid in
            self.navigationItem.rightBarButtonItem?.isEnabled = valid
        }).disposed(by: disposeBag)
    }


    private func setupNavbar() {
        self.navigationItem.title = "Edit Note"
        let btnSave = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onTapSave))
        self.navigationItem.rightBarButtonItem = btnSave
    }
    
    @objc private func onTapSave() {
        viewModel.saveNote(title: txtFieldTitle.text ?? "", desc: txtViewDesc.text)
        self.navigationController?.popViewController(animated: true)
    }

}
