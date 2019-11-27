//
//  UIStoryboard+Controllers.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit

//MARK:- UIStoryboard
extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var contacts: UIStoryboard {
        return UIStoryboard(name: "Contacts", bundle: nil)
    }
}

//MARK:- Get UIViewController
extension UIStoryboard {
    
    /// Get view controller from storyboard by its class type
    /// Usage: let profileVC = storyboard!.get(ProfileViewController.self) /* profileVC is of type ProfileViewController */
    /// Warning: identifier should match storyboard ID in storyboard of identifier class
    public func get<T:UIViewController>(_ identifier: T.Type) -> T {
        let storyboardID = String(describing: identifier)
        
        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError(String(describing: identifier.self) + pString(.notFoundInStoryboard))
        }
        
        return viewController
    }
}

