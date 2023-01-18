//
//  HomeViewController.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var tableViewNotes: UITableView!
    
    private var viewModel: HomeViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = HomeViewModel(noteModel: NoteModelImpl.shared)
        
        setupNavbar()
        
        setupTableView()
        
        observeNoteList()
    }


    private func setupNavbar() {
//        self.navigationItem.title = "BinaryNote"
        let lblTitle = UILabel()
        lblTitle.textColor = .label
        lblTitle.text = "Binary Note"
        lblTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: lblTitle)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "colorPrimary")
        let btnCreate = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapCreate))
        self.navigationItem.rightBarButtonItem = btnCreate
    }
    
    private func setupTableView() {
        tableViewNotes.dataSource = self
        tableViewNotes.delegate = self
        tableViewNotes.registerForCell(identifier: NoteItemTableViewCell.identifier)
    }
    
    private func observeNoteList() {
        viewModel.noteList.subscribe(onNext: { _ in
            self.tableViewNotes.reloadData()
        }).disposed(by: disposeBag)
    }
    
    @objc private func onTapCreate() {
        navigateToNewNoteViewController()
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNoteCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(identifier: NoteItemTableViewCell.identifier, indexPath: indexPath) as NoteItemTableViewCell
        cell.data = viewModel.getNote(by: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
            let delete = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completionHandler) in
                self.viewModel.deleteNote(by: indexPath.row)
                completionHandler(true)
            }
            delete.image = UIImage(systemName: "trash")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
            delete.backgroundColor = UIColor.red
            let swipe = UISwipeActionsConfiguration(actions: [delete])
            return swipe
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToNoteDetailViewController(id: viewModel.getNoteId(by: indexPath.row))
    }
}
