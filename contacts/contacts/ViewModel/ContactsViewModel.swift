//
//  ProductsViewModel.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct GroupedContacts {
    let title: String
    let contacts: [Contact]
}


class ContactsViewModel: BaseViewModel {
    typealias Dependencies = HasContactsAPI
    
    // Dependencies
    let dependencies: Dependencies
    
    let addContactTaps = PublishSubject<Void>()
    let groupsTaps = PublishSubject<Void>()
    
    let selectedIndexPath: BehaviorRelay<IndexPath?> = BehaviorRelay<IndexPath?>(value: nil)
    let selectedContact: BehaviorRelay<Contact?> = BehaviorRelay<Contact?>(value: nil)
    let contacts: BehaviorRelay<[Contact]> = BehaviorRelay<[Contact]>(value: [])
    let groupedContacts: BehaviorRelay<[GroupedContacts]> = BehaviorRelay<[GroupedContacts]>(value: [])
    
    var sectionTitles: [String]? {
        return groupedContacts.value.compactMap({ $0.title })
    }
    
    var contactsResponse: Observable<ContactsResponse> {
        return _contactsResponse.asObservable().observeOn(MainScheduler.instance)
    }
    private let _contactsResponse = ReplaySubject<ContactsResponse>.create(bufferSize: 1)
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
        
        selectedIndexPath
            .subscribe(onNext: { [weak self] (indexPath) in
                guard let `self` = self, let indexPath = indexPath else { return }
                self.selectedContact.accept(self.groupedContacts.value[indexPath.section].contacts[indexPath.row])
            }).disposed(by: disposeBag)
        
        contactsResponse
            .subscribe(onNext: { [weak self] (response) in
                guard let `self` = self else { return }
                self.contacts.accept(response)
            }).disposed(by: disposeBag)
        
        contacts.asObservable().map { (contacts) -> [GroupedContacts] in
            
            let sortedContacts = contacts.sorted(by: { $0.nameToDisplay < $1.nameToDisplay })
            var tempGroupedContacts: [GroupedContacts] = []
            let titles = UILocalizedIndexedCollation.current().sectionTitles
            for title in titles {
                let contacts = sortedContacts.filter({ $0.nameToDisplay.hasPrefix(title)})
                tempGroupedContacts.append(GroupedContacts(title: title, contacts: contacts))
            }
            return tempGroupedContacts
            
        }.bind(to: groupedContacts).disposed(by: disposeBag)
        
        getContacts()
    }
    
    func groupContacts(_ contacts: [Contact]) -> [GroupedContacts] {
        
        let sortedContacts = contacts.sorted(by: { $0.nameToDisplay < $1.nameToDisplay })
        var tempGroupedContacts: [GroupedContacts] = []
        let titles = UILocalizedIndexedCollation.current().sectionTitles
        for title in titles {
            let contacts = sortedContacts.filter({ $0.nameToDisplay.hasPrefix(title)})
            tempGroupedContacts.append(GroupedContacts(title: title, contacts: contacts))
        }
        return tempGroupedContacts
    }
}

// Networking
extension ContactsViewModel {
    
    func getContacts() -> Void {
        dependencies.contactsAPIs
            .contacts()
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let response):
                    self._contactsResponse.onNext(response)
                case .failure:
                    self.alert.onNext((pString(.genericError), .error))
                }
            }).disposed(by: disposeBag)
    }
    
    func createContact(info: CreateContactInfo) -> Void {
        dependencies.contactsAPIs
            .createContact(info: info)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let response):
                    self._contactsResponse.onNext(response)
                case .failure:
                    self.alert.onNext((pString(.genericError), .error))
                }
            }).disposed(by: disposeBag)
    }
}
