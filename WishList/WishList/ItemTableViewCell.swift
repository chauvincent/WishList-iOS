//
//  ItemTableViewCell.swift
//  WishList
//
//  Created by Vincent Chau on 11/1/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(item: Item) {
        itemNameLabel.text = item.title
        itemPriceLabel.text = "$\(item.price)"
        itemDescriptionLabel.text = item.details
        itemImageView.image = item.toWishImage?.image as? UIImage
    }

}
