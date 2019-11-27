//
//  ContactInfoViewController.swift
//  contacts
//
//  Created by prathvi on 09/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - ContactInfoViewController
class ContactInfoViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var EditButton: UIBarButtonItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    // MARK: - Internal Properties
    var viewModel: ContactInfoViewModel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK:- Setup View and Bindings
extension ContactInfoViewController {
    
    private func setup() -> Void {
        
        setupUI(with: viewModel)
        setupBindings(forViewModel: viewModel)
    }
    
    private func setupUI(with viewModel: ContactInfoViewModel) -> Void {
        configureTableView()
    }
    
    private func setupBindings(forViewModel viewModel: ContactInfoViewModel) -> Void {
        
        viewModel.contactInfo
            .subscribe(onNext: { [weak self] (contactInfo) in
                guard let `self` = self, let contactInfo = contactInfo else { return }
                
                self.nameLabel.text = contactInfo.nameToDisplay
                self.profileImageView.image(url: contactInfo.photo)
                self.favouriteImageView.isHighlighted = contactInfo.isFavorite
                
                self.formTableView.reloadData()
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
extension ContactInfoViewController {
    
    func configureTableView() -> Void {
        formTableView.tableFooterView = UIView()
        formTableView.register(UINib(nibName: String(describing: ContactInfoTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: ContactInfoTableViewCell.self))
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension ContactInfoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.infoData.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactInfoTableViewCell.self), for: indexPath) as! ContactInfoTableViewCell
        cell.configure(data: viewModel.infoData.value[indexPath.row])
        return cell
    }
}

