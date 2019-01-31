//
//  MapViewController.swift
//  FoodPinApp
//
//  Created by Jithin on 23/01/19.
//  Copyright © 2019 Jithin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView:MKMapView!
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        initMap()
    }
    
    func initMap(){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
            if error == nil{
                if let placemarks = placemarks{
                    let placemark = placemarks[0]
                    let annotation = MKPointAnnotation()
                    annotation.title = self.restaurant.name
                    annotation.subtitle = self.restaurant.type
                    
                    
                    if let location = placemark.location{
                        annotation.coordinate = location.coordinate
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                    
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if annotation .isKind(of: MKUserLocation.self){
            return nil
        }
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.blue
        }
        let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: restaurant.image)
        annotationView?.leftCalloutAccessoryView = imageView
        
        return annotationView
        
    }
    
    
}
