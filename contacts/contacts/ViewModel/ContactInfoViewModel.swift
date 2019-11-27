//
//  ContactInfoViewModel.swift
//  contacts
//
//  Created by prathvi on 09/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ContactInfoType {
    case firstName, lastName, email, mobile
}

class ContactInfoData {
    var description: String!
    var info: String!
    var infoType: ContactInfoType
    var keyboard: UIKeyboardType
    
    init(description: String, info: String?, infoType: ContactInfoType, keyboard: UIKeyboardType = .default) {
        
        self.description = description
        self.info = info
        self.infoType = infoType
        self.keyboard = keyboard
    }
}

class ContactInfoViewModel: BaseViewModel {
    typealias Dependencies = HasContactsAPI
    
    // Dependencies
    let dependencies: Dependencies
    
    let contact: Contact
    
    let editContactTaps = PublishSubject<Void>()
    let backTaps = PublishSubject<Void>()
    
    let contactInfo: BehaviorRelay<ContactInfo?> = BehaviorRelay<ContactInfo?>(value: nil)
    
    let infoData: BehaviorRelay<[ContactInfoData]> = BehaviorRelay<[ContactInfoData]>(value: [])
    
    var contactInfoResponse: Observable<ContactInfo> {
        return _contactInfoResponse.asObservable().observeOn(MainScheduler.instance)
    }
    private let _contactInfoResponse = ReplaySubject<ContactInfo>.create(bufferSize: 1)
    
    init(contact: Contact, dependencies: Dependencies) {
        self.dependencies = dependencies
        self.contact = contact
        
        super.init()
        
        contactInfoResponse
            .subscribe(onNext: { [weak self] (response) in
                guard let `self` = self else { return }
                self.contactInfo.accept(response)
            }).disposed(by: disposeBag)
        
        contactInfo.asObservable().map { (contactInfo) -> [ContactInfoData] in
            
            guard let contactInfo = contactInfo else {
                return []
            }
            
            return [ContactInfoData(description: "email", info: contactInfo.email, infoType: .email), ContactInfoData(description: "mobile", info: contactInfo.phoneNumber, infoType: .mobile)]
            
            }.bind(to: infoData).disposed(by: disposeBag)
        
        getContactInfo(id: contact.id)
    }
}

// Networking
extension ContactInfoViewModel {
    
    func getContactInfo(id: Int) -> Void {
        
        dependencies.contactsAPIs
            .contactInfo(id: id)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let response):
                    self._contactInfoResponse.onNext(response)
                case .failure:
                    self.alert.onNext((pString(.genericError), .error))
                }
            }).disposed(by: disposeBag)
    }
}

