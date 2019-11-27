//
//  ContactTableViewCell.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(data: ProductInfo) -> Void {
        titleLabel.text = data.product.title
    }
    
    func configure(data: Contact) -> Void {
        
        titleLabel.text = data.nameToDisplay
        profileImageView.image(url: data.photo)
    }
}
