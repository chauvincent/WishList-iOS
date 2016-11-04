//
//  ItemDetailsVC.swift
//  WishList
//
//  Created by Vincent Chau on 11/1/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    
    var imagePicker: UIImagePickerController!
    var stores = [Store]()
    var editItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if editItem != nil {
            loadEditItem()
        }
        
        //loadFakeStores()
        loadStores()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    // MARK: - Edit Item
    func loadEditItem() {
        
        if let item = editItem {
            titleTextField.text = item.title
            priceTextField.text = "\(item.price)"
            detailTextField.text = item.details
            
            guard let store = item.toStore else { return }
            
            var index = 0
            
            while index < stores.count {
                
                let currentStore = stores[index]
                
                if currentStore.name == store.name {
                    pickerView.selectRow(index, inComponent: 0, animated: true)
                    break
                }
                
                index += 1
            }
        }
        
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
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        
          present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        guard let item = editItem else { return }
        context.delete(item)
        ad.saveContext()
        _ =  navigationController?.popViewController(animated: true)
    
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        
        var item: Item!
        
        if editItem == nil {
            item = Item(context: context)
        
        } else {
            item = editItem
        }
        
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

    // MARK: - <UIImagePickerDelegate>
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        itemImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}
