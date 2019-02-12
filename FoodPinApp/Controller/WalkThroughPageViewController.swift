//
//  WalkThroughPageViewController.swift
//  FoodPinApp
//
//  Created by Jithin on 07/02/19.
//  Copyright © 2019 Jithin. All rights reserved.
//

import UIKit

class WalkThroughPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    
    var headings = ["Personalize","Locate","Discover"]
    var images = ["foodpin-intro-1","foodpin-intro-2","foodpin-intro-3"]
    var content = ["Pin your favorite restaurants and create your own food guide","Search and locate your favorite restaurant on Maps","Find restaurants pinned by your friends and other foodies aroudn the world"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstController = contentViewController(at: 0){
            setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughController).index
        index += 1
        return contentViewController(at: index)
    }
    
    func contentViewController(at index:Int) -> WalkThroughController?{
        
        if index < 0 || index >= headings.count{
            return nil
        }
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "contentviewcontroller") as? WalkThroughController{
            viewController.heading = headings[index]
            viewController.content = content[index]
            viewController.imageFile = images[index]
            viewController.index = index
            return viewController
            
        }
       return nil
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return headings.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "contentviewcontroller") as? WalkThroughController{
            return controller.index
        }
        return 0
    }
    
    func forward(index:Int){
        if let controller = contentViewController(at: index + 1){
           setViewControllers([controller], direction: .forward, animated: true, completion: nil)
        }
    }
}
