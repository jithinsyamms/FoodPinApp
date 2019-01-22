//
//  Restaurant.swift
//  FoodPinApp
//
//  Created by Jithin on 27/11/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class Restaurant: NSObject {
    
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var rating = ""
    
    init(name:String,type:String,location:String,image:String, isVisited:Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
}
