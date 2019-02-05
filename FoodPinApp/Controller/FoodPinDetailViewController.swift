//
//  FoodPinDetailViewController.swift
//  FoodPinApp
//
//  Created by Jithin on 30/11/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit
import MapKit

class FoodPinDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var mapView:MKMapView!
    var restaurant:RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor.lightGray
        restaurantImage.image = UIImage(data: restaurant.image!)
        title = restaurant.name
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMap))
        mapView.addGestureRecognizer(tapGesture)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!) { (placemarks, error) in
            
            if error == nil{
                if let placemarks = placemarks{
                    let placemark = placemarks[0]
                    let annotation = MKPointAnnotation()
                    if let location = placemark.location{
                        annotation.coordinate = location.coordinate
                         self.mapView.addAnnotation(annotation)
                        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                        self.mapView.setRegion(region, animated: false)
                    }
                }
            }
            
        }
        
    }
    
    @objc func openMap(){
        performSegue(withIdentifier: "showMap", sender: self)
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
        
        if segue.identifier == "showMap"{
            let destination = segue.destination as! MapViewController
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
