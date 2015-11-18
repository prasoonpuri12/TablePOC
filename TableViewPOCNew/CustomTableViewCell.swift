//
//  CustomTableViewCell.swift
//  TableViewPOC
//
//  Created by Prasoon Puri on 10/29/15.
//  Copyright (c) 2015 Prasoon Puri. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRollNumber: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
