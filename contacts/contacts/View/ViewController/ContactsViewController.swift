//
//  ContactsViewController.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - ContactsViewController
class ContactsViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var addContactButton: UIBarButtonItem!
    @IBOutlet weak var groupsButton: UIBarButtonItem!
    @IBOutlet weak var contactsTableView: UITableView!
    
    // MARK: - Internal Properties
    var viewModel: ContactsViewModel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK:- Setup View and Bindings
extension ContactsViewController {
    
    private func setup() -> Void {
        
        setupUI(with: viewModel)
        setupBindings(forViewModel: viewModel)
    }
    
    private func setupUI(with viewModel: ContactsViewModel) -> Void {
        configureTableView()
    }
    
    private func setupBindings(forViewModel viewModel: ContactsViewModel) -> Void {
        
        contactsTableView.rx
            .itemSelected
            .bind(to: viewModel.selectedIndexPath)
            .disposed(by: disposeBag)
        
        viewModel.groupedContacts
            .subscribe(onNext: { [weak self] (groupedContacts) in
                guard let `self` = self else { return }
                self.contactsTableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.alert
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (message, theme) in
                guard let `self` = self else { return }
                self.alert(message, theme: theme)
            }).disposed(by: disposeBag)
        
        viewModel.isLoading.distinctUntilChanged().drive(onNext: { [weak self] (isLoading) in
            guard let `self` = self else { return }
            self.hideActivityIndicator()
            if isLoading {
                self.showActivityIndicator()
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Helper Functions
extension ContactsViewController {
    
    func configureTableView() -> Void {
        
        contactsTableView.tableFooterView = UIView()
        contactsTableView.register(UINib(nibName: String(describing: ContactTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: ContactTableViewCell.self))
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.groupedContacts.value[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.groupedContacts.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groupedContacts.value[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactTableViewCell.self), for: indexPath) as! ContactTableViewCell
        cell.configure(data: viewModel.groupedContacts.value[indexPath.section].contacts[indexPath.row])
        return cell
    }
}
