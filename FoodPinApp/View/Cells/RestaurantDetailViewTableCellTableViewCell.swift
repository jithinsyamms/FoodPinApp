//
//  RestaurantDetailViewTableCellTableViewCell.swift
//  FoodPinApp
//
//  Created by Jithin on 11/01/19.
//  Copyright © 2019 Jithin. All rights reserved.
//

import UIKit

class RestaurantDetailViewTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
