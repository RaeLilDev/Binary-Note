//
//  NewNoteViewController.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import UIKit
import RxSwift
import RxCocoa

class NewNoteViewController: UIViewController {

    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtViewDesc: UITextView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: NewNoteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupNavbar()
        
        bindInputFields()
    }
    
    private func setupView() {
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
    
    private func bindInputFields() {
        txtFieldTitle.rx.text.map{ $0 ?? ""}.bind(to: viewModel.titleSubject).disposed(by: disposeBag)
        txtViewDesc.rx.text.map { $0 ?? ""}.bind(to: viewModel.descSubject).disposed(by: disposeBag)
        
        viewModel.isValid().subscribe(onNext: { valid in
            self.navigationItem.rightBarButtonItem?.isEnabled = valid
        }).disposed(by: disposeBag)
    }


    private func setupNavbar() {
        self.navigationItem.title = "New Note"
        let btnDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onTapDone))
        self.navigationItem.rightBarButtonItem = btnDone
    }
    
    @objc private func onTapDone() {
        viewModel.saveNote()
        self.navigationController?.popViewController(animated: true)
    }

}
