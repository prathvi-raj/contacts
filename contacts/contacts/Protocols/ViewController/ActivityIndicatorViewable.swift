//
//  ActivityIndicatorViewable.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ActivityIndicatorViewable {
    
    func showActivityIndicator(in _containerView:UIView?) -> Void
    func hideActivityIndicator(from containerView:UIView?) -> Void
}

extension ActivityIndicatorViewable where Self: UIViewController {
    
    func showActivityIndicator(in _containerView:UIView? = nil) -> Void {
        var containerView:UIView = self.view
        
        if let _containerView = _containerView {
            containerView = _containerView
        }
        
        hideActivityIndicator(from: containerView)
        
        let hud = MBProgressHUD.showAdded(to: containerView, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.backgroundView.color = UIColor.black.withAlphaComponent(0.3)
        hud.backgroundView.style = .solidColor
    }
    
    func hideActivityIndicator(from _containerView:UIView? = nil) -> Void {
        var containerView:UIView = self.view
        
        if let _containerView = _containerView {
            containerView = _containerView
        }
        
        MBProgressHUD.hideAllHUDs(for: containerView, animated: true)
    }
}

extension ActivityIndicatorViewable where Self: UIView {
    
    func showActivityIndicator(in _containerView:UIView? = nil) -> Void {
        var containerView:UIView = self
        
        if let _containerView = _containerView {
            containerView = _containerView
        }
        
        hideActivityIndicator(from: containerView)
        
        let hud = MBProgressHUD.showAdded(to: containerView, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.backgroundView.color = UIColor.clear
        hud.backgroundView.style = .blur
    }
    
    func hideActivityIndicator(from _containerView:UIView? = nil) -> Void {
        var containerView:UIView = self
        
        if let _containerView = _containerView {
            containerView = _containerView
        }
        
        MBProgressHUD.hideAllHUDs(for: containerView, animated: true)
    }
}



