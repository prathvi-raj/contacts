//
//  AppCoordinator.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import RxSwift

final class AppCoordinator: Coordinator<Void> {
    
    private let navigationController: UINavigationController
    private let window: UIWindow
    let dependencies: AppDependency
    
    init(window:UIWindow, navigationController: UINavigationController) {
        
        self.window = window
        self.navigationController = navigationController
        self.dependencies = AppDependency(window: self.window)
    }
    
    override func start() -> Observable<Void> {
        return showContacts()
    }
    
    deinit {
        plog(AppCoordinator.self)
    }
}

extension AppCoordinator {
    
    private func showContacts() -> Observable<Void> {
        
        let coordinator = ContactsCoordinator(navigationController: navigationController, dependencies: self.dependencies)
        return coordinate(to: coordinator)
    }
}
