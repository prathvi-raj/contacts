//
//  BaseViewModel.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftMessages

enum CoordinatorError {
    case noInternetConnection
}

typealias CoordinationTask = (() -> Void)?

class BaseViewModel {
    
    // Dispose Bag
    let disposeBag = DisposeBag()
    let coordinatorError = PublishSubject<(CoordinationTask, CoordinatorError)>()
    let alert = PublishSubject<(String, Theme)>()
    let alertDialog = PublishSubject<(String,String)>()
    let isLoading: ActivityIndicator =  ActivityIndicator()
    let isMemoryLow: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
}


