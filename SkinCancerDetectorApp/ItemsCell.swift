//
//  ItemsCell.swift
//  HealthApp
//
//  Created by Himanshu Joshi on 21/02/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit

class ItemsCell: UITableViewCell {
    
    @IBOutlet weak var itemDistance: UILabel!
    @IBOutlet weak var itemPhone: UILabel!
    @IBOutlet weak var itemAddress: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    func configureCell(items: Items) {
        itemName.text = items.itemName
        itemAddress.text = items.itemAddress
        itemPhone.text = items.itemPhone
        itemDistance.text = items.itemDistance
    }
    
}
