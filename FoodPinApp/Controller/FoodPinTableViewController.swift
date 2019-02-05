//
//  FoodPinTableViewController.swift
//  FoodPinApp
//
//  Created by Jithin on 27/11/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit
import CoreData

class FoodPinTableViewController: UITableViewController,AddRestaurantCompletionDelegate,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    
    
    var restaurants:[RestaurantMO] = []
    var fetchResultController:NSFetchedResultsController<RestaurantMO>!
    
    var searchController:UISearchController!
    var searchResults:[RestaurantMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        loadRestaurants()
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.placeholder = "Search Restaurants.."
        searchController.searchBar.barTintColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 0.5)
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    func loadRestaurants(){
        
        let fetchRequest:NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do{
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects{
                    restaurants = fetchedObjects
                }
            }
            catch{
                
            }
            
       //  self.tableView.reloadData()
        }
    }
    
    func performSearch(for searchText:String){
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name{
                if searchText.isEmpty{
                    return true
                }
                return name.localizedCaseInsensitiveContains(searchText)
            }
            return false;
        })
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            performSearch(for: searchText)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive{
            return searchResults.count
        }
        else{
            return restaurants.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.restaurantName.text = restaurant.name
        cell.restaurantLocation.text = restaurant.location
        cell.restaurantType.text = restaurant.type
        cell.restaurantImage.image =  UIImage(data: restaurant.image! )
        cell.restaurantImage.layer.cornerRadius = 30
        cell.restaurantImage.clipsToBounds = true
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !searchController.isActive
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let activityController = UIActivityViewController(activityItems: [self.restaurants[indexPath.row].name!], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor.lightGray
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                let context = appDelegate.persistentContainer.viewContext
                let objectToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(objectToDelete)
                appDelegate.saveContext()
            }
            
            
        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction,shareAction]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                 let destination = segue.destination as! FoodPinDetailViewController
                destination.restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
        if segue.identifier == "addRestaurant"{
//            let navigationController = segue.destination as! UINavigationController
//            let controllers = navigationController.viewControllers
//            let destination = controllers[0] as! AddRestaurantController
//            destination.delegate = self
        }
        
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue){
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
         case .insert:
            if let newIndexPath = newIndexPath{
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath{
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
        default:
            tableView.reloadData()
        }
        if let fetchedObjectes = controller.fetchedObjects{
            restaurants = fetchedObjectes as! [RestaurantMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func restaurantAdded() {
         loadRestaurants()
    }

}
