//
//  viewControllerTableViewCell.swift
//  firebase01
//
//  Created by Nitish Chauhan on 07/12/18.
//  Copyright © 2018 Nitish Chauhan. All rights reserved.
//

import UIKit

class viewControllerTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblgenre: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
