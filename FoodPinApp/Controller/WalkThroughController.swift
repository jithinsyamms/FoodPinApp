//
//  WalkThroughController.swift
//  FoodPinApp
//
//  Created by Jithin on 07/02/19.
//  Copyright © 2019 Jithin. All rights reserved.
//

import UIKit

class WalkThroughController: UIViewController {

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var headinglabel: UILabel!
    @IBOutlet weak var contentlabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headinglabel.text = heading
        contentlabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        
        switch index {
        case 0...1:
            forwardButton.setTitle("NEXT", for: .normal)
        case 2:
            forwardButton.setTitle("DONE", for: .normal)
        default:
            break
        }
    }
    
    @IBAction func nextButtonTapped(sender:UIButton){
        switch index {
        case 0...1:
            let pageController = parent as! WalkThroughPageViewController
            pageController.forward(index: index)
            
        case 2:
            UserDefaults.standard.set(true, forKey: "walkthroughDone")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
        
        
    }
}
