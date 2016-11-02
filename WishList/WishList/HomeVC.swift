//
//  HomeViewController.swift
//  WishList
//
//  Created by Vincent Chau on 10/31/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        itemTableView.dataSource = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
   
        return cell
    }
}

