//
//  detailViewController.swift
//  TableViewPOC
//
//  Created by Prasoon Puri on 10/30/15.
//  Copyright (c) 2015 Prasoon Puri. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    var studentName : String?
    var className : String?
    var rollNumber : Int?

    @IBOutlet weak var lblRollNumber: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = studentName
        lblClass.text = className
        lblRollNumber.text = rollNumber?.description

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
