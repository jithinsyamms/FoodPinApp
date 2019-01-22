//
//  RestaurantTableViewCell.swift
//  FoodPinApp
//
//  Created by Jithin on 27/11/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantLocation: UILabel!
    @IBOutlet weak var restaurantType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
