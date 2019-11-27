//
//  ContactInfoTableViewCell.swift
//  contacts
//
//  Created by prathvi on 27/11/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit

class ContactInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func configure(data: ContactInfoData) -> Void {
        
        descriptionLabel.text = data.description
        infoLabel.text = data.info
    }
}
