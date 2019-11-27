//
//  AppDependency.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit

protocol HasWindow {
    var window: UIWindow? { get }
}

protocol HasContactsAPI {
    var contactsAPIs: ContactsAPIs { get }
}

class AppDependency: HasWindow, HasContactsAPI {
    let window: UIWindow?
    var contactsAPIs: ContactsAPIs
    
    init(window: UIWindow? = nil) {
        
        self.window = window
        self.contactsAPIs = ContactsAPIs()
    }
}
