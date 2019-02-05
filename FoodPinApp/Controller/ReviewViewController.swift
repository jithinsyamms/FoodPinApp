//
//  ReviewViewController.swift
//  FoodPinApp
//
//  Created by Jithin on 17/01/19.
//  Copyright © 2019 Jithin. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    var restaurant:RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImage.addSubview(blurEffectView)
        imageView.image = UIImage(data: restaurant.image!)
        
        
        //containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
        //containerView.transform = CGAffineTransform.init(translationX: 0, y: -1000)
        
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combinedTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combinedTransform
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.containerView.transform = CGAffineTransform.identity
        }
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
//             self.containerView.transform = CGAffineTransform.identity
//        }, completion: nil)
    }
    
    
}
