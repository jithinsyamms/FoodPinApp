//
//  AddRestaurantController.swift
//  FoodPinApp
//
//  Created by Jithin on 29/01/19.
//  Copyright © 2019 Jithin. All rights reserved.
//

import UIKit
import CoreData

protocol AddRestaurantCompletionDelegate {
    func restaurantAdded()
}


class AddRestaurantController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var restaurant:RestaurantMO!
    var isVisited:Bool = false
    
    var delegate:AddRestaurantCompletionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            photoView.image = image
            photoView.contentMode = .scaleAspectFill
            photoView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
        
        let leadingAttribute = NSLayoutConstraint(item: photoView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoView.superview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        leadingAttribute.isActive = true
        
        let trailingAttribute = NSLayoutConstraint(item: photoView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoView.superview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        trailingAttribute.isActive = true
        
        let topAttribute = NSLayoutConstraint(item: photoView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoView.superview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        topAttribute.isActive = true
        
        let bottomAttribute = NSLayoutConstraint(item: photoView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoView.superview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        bottomAttribute.isActive = true
        
    }

    @IBAction func saveClicked(_ sender: Any) {
        if nameField.text?.isEmpty ?? true || typeField.text?.isEmpty ?? true || locationField.text?.isEmpty ?? true {
            
            let alertController = UIAlertController(title: "Oops!", message: "Field Missing", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
        else{
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = nameField.text
                restaurant.type = typeField.text
                restaurant.location = locationField.text
                restaurant.isVisited = isVisited
                
                if let image = photoView.image{
                    if let imageData = image.pngData(){
                        restaurant.image = NSData(data: imageData) as Data
                    }
                }
                appDelegate.saveContext()
                dismiss(animated:true, completion: nil)
                delegate?.restaurantAdded()
            }
            
        }
    }
    
    @IBAction func toggleBeenHere(sender:UIButton){
        if sender.tag == 0{
            isVisited = true
            yesButton.backgroundColor = UIColor.red
            noButton.backgroundColor = UIColor.lightGray
        }
        else{
            isVisited = false
            yesButton.backgroundColor = UIColor.lightGray
            noButton.backgroundColor = UIColor.red
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
