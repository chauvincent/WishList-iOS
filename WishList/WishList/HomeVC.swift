//
//  HomeViewController.swift
//  WishList
//
//  Created by Vincent Chau on 10/31/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    var fetchedResultsController: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        attemptFetch()
        loadFakeData()
      
    }

    // MARK: - UITableViewDataSource
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    // MARK: - Helpers
    
    func configureCell(cell: ItemTableViewCell, indexPath: NSIndexPath) {
        let item = fetchedResultsController.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    // MARK: - CoreData Helpers
    
    func loadFakeData() {
        
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 1800
        item.details = "Toolbar... yay or neh?"
        item.created = NSDate()
        
        let item2 = Item(context: context)
        item2.title = "Apple Watch Series 2"
        item2.price = 1800
        item2.details = "Useful? I hope so."
        item.created = NSDate()
        
        let item3 = Item(context: context)
        item3.title = "iMac"
        item3.price = 1800
        item3.details = "iMac for home"
        item.created = NSDate()
        
        ad.saveContext()
        
    }
    
    
    func attemptFetch() {
        
        // Create fetch request
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        // Sort
        let recentSort = NSSortDescriptor(key: "title", ascending: false)
        
        fetchRequest.sortDescriptors = [recentSort]
        
        // FRC Controller
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Perform fetch
        do {
            
            try self.fetchedResultsController.performFetch()
        
        } catch {
        
            let error = error as NSError
            print("\(error)")
        
        }
        
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    // When table view updates, listen for changes and handle it
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        itemTableView.beginUpdates()
        
        
    }
    
    // Once table view did change
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        itemTableView.endUpdates()
    }
    
    // Listen for when making a change (insert,delete,modification) NSFetchedResultsChagneType
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                itemTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                itemTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                // When a cell is updated, update the cell locally
                let cell = itemTableView.cellForRow(at: indexPath) as! ItemTableViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                itemTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                itemTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
}

