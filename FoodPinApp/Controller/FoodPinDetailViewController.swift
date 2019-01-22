//
//  FoodPinDetailViewController.swift
//  FoodPinApp
//
//  Created by Jithin on 30/11/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class FoodPinDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var restaurantImage: UIImageView!
    var restaurant:Restaurant?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor.lightGray
        restaurantImage.image = UIImage(named: restaurant?.image ?? "wafflewolf.jpg")
        title = restaurant?.name
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! RestaurantDetailViewTableCellTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.field.text = "Name"
            cell.value.text = restaurant?.name
        case 1:
            cell.field.text = "Type"
            cell.value.text = restaurant?.type
        case 2:
            cell.field.text = "Location"
            cell.value.text = restaurant?.location
        case 3:
            cell.field.text = "Been here"
            cell.value.text = restaurant?.isVisited ?? false ? " YES, I've been here before.\(String(describing: restaurant?.rating)) " : "NO"
        default:
            cell.field.text = ""
            cell.value.text = ""
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview"{
            let destination = segue.destination as! ReviewViewController
            destination.restaurant = restaurant
        }
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func ratingButonTapped(segue:UIStoryboardSegue){
        if let rating = segue.identifier{
            restaurant?.isVisited = true
            
            
            
            switch rating {
                
            case "great":
                  restaurant?.rating = "Absolutely love it. Must try"
            case "good":
                  restaurant?.rating = "Pretty Good"
            case "dislike":
                  restaurant?.rating = "I don't like it"
            default:
                    break
            }
            tableView.reloadData()
        }
    }

}
