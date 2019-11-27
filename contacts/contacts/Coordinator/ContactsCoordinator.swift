//
//  ContactsCoordinator.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import RxSwift

class  ContactsCoordinator: Coordinator<Void> {
    typealias Dependencies = HasContactsAPI & HasWindow
    
    private let navigationController: UINavigationController
    private let dependencies: Dependencies
    
    init(navigationController: UINavigationController, dependencies: Dependencies) {
        
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<Void> {
        
        let viewModel = ContactsViewModel(dependencies: self.dependencies)
        let contactsNavigationController = UIStoryboard.contacts.get(ContactsNavigationController.self)
        let viewController = contactsNavigationController.viewControllers.first as! ContactsViewController
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
        
        viewModel.selectedContact
            .subscribe(onNext: { [weak self] (contact) in
                guard let `self` = self, let contact = contact else { return }
                self.showContactInfoView(contact: contact)
            }).disposed(by: disposeBag)
        
        self.dependencies.window?.rootViewController = navigationController
        return Observable.never()
    }
}

extension ContactsCoordinator {
    
    @discardableResult
    private func showContactInfoView(contact: Contact) -> Observable<Void> {
        
        let viewModel = ContactInfoViewModel(contact: contact, dependencies: self.dependencies)
        let viewController = UIStoryboard.contacts.get(ContactInfoViewController.self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
}
