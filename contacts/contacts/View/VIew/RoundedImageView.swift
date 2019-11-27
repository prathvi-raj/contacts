//
//  RoundedImageView.swift
//  contacts
//
//  Created by prathvi on 27/11/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit

@IBDesignable class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
