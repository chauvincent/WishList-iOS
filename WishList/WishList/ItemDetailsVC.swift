//
//  ItemDetailsVC.swift
//  WishList
//
//  Created by Vincent Chau on 11/1/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var detailLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var titleNameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
