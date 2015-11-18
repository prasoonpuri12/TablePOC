//
//  Profile.swift
//  TableViewPOC
//
//  Created by Prasoon Puri on 10/30/15.
//  Copyright (c) 2015 Prasoon Puri. All rights reserved.
//

import UIKit
import CoreData

class Profile: NSObject {
    
    static var recordArray = [Profile]()
    static var recordArrayDOB = [NSManagedObject]()
    var className : String?
    var rollNumber : Int?
    var studentName : String?
    
    func setRecord(var className : String , var rollNum : Int , var stuName : String)
    {
         self.className = className
         self.rollNumber = rollNum
         self.studentName = stuName
    }
   
    func getClassName()->String
    {
        return self.className!
    }
    
    func getRollNumber()->String
    {
        var myRollNumber = self.rollNumber?.description
        return myRollNumber!
    }
    
    func getStudentName()->String
    {
        return self.studentName!
    }
}
