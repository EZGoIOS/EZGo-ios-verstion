//
//  MenuTableViewCell.swift
//  ezgo1
//
//  Created by vickyliao on 2017/11/22.
//  Copyright © 2017年 vickyliao. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet var lblMenuName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
