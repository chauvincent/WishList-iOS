//
//  ItemDetailsVC.swift
//  WishList
//
//  Created by Vincent Chau on 11/1/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        pickerView.delegate = self
        pickerView.dataSource = self
        loadFakeStores()
        loadStores()
    }

    // MARK: - Core Data Helpers
    
    func loadFakeStores() {
        
        let store = Store(context: context)
        store.name = "Apple Store Cupertino"
        let store2 = Store(context: context)
        store2.name = "Apple Store San Francisco"
        let store3 = Store(context: context)
        store3.name = "Apple Store San Jose"
        let store4 = Store(context: context)
        store4.name = "Apple Store Elk Grove"
        let store5 = Store(context: context)
        store5.name = "Apple Store Palo Alto"
        
        ad.saveContext()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let item = Item(context: context)
        
        guard let title = titleTextField.text else { return }
        item.title = title
        
        guard let details = detailTextField.text else { return }
        item.details = details
        
        if let price = priceTextField.text {
            item.price = (price as NSString).doubleValue
        }
        
        // Store Item Relationship
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        ad.saveContext()
        
        _ =  navigationController?.popViewController(animated: true)
    }

    // MARK: - Fetch
    
    func loadStores() {
        
        // Create fetch request
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
       
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
            
        }
    }
    
    // MARK: - <UIPickerViewDataSource>
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let currentStore = stores[row]
        
        return currentStore.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}
