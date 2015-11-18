//
//  TableViewController.swift
//  TableViewPOC
//
//  Created by Prasoon Puri on 10/29/15.
//  Copyright (c) 2015 Prasoon Puri. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let appdelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var tableViewReference: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
         return Profile.recordArrayDOB.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        //Extracting the Attribute Values From database
           var attributes =  extractRecords(indexPath.row)
            cell.lblClass.text = attributes.classname
            cell.lblName.text = attributes.name
            cell.lblRollNumber.text = attributes.rollnumber.description
       
        return cell

    }
   
    // Function to tell the number of section in the Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    // Function to delete the record from the Table and Array
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            deleteRecordFromDatabase(indexPath.row)
            Profile.recordArrayDOB.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
    }
    
    // Function to fetch the attributes from the database
    func extractRecords(var index : Int) -> (name : String , classname : String , rollnumber : Int)
    {
        var className: String = Profile.recordArrayDOB[index].valueForKey("classname") as! String
        var studentName: String = Profile.recordArrayDOB[index].valueForKey("studentname") as! String
        var rollNumber : Int = Profile.recordArrayDOB[index].valueForKey("rollnumber") as! Int
        
        return(studentName , className , rollNumber)
    }
    
    
    // Function to delete the record from Database
    func deleteRecordFromDatabase(var index : Int)
    {
        var errorPointer : NSErrorPointer = nil
        let managedcontext : NSManagedObjectContext = self.appdelegate.managedObjectContext!
        print(managedcontext.deleteObject(Profile.recordArrayDOB[index]))
        managedcontext.deleteObject(Profile.recordArrayDOB[index])
        print(Profile.recordArrayDOB[index])
        if(!(managedcontext.save(errorPointer))) {
            println("Unable to find ManagedObjectContext")
            println("ERROR : ",errorPointer.debugDescription)
        }
    }
    
    // Function to send the details to next screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if(segue.identifier == "showDetails")
        {
        let indexPathSelected = self.tableViewReference.indexPathForSelectedRow()

        
        let cell = self.tableViewReference.cellForRowAtIndexPath(indexPathSelected!) as! CustomTableViewCell
            
        var detailControllerObj = segue.destinationViewController as! detailViewController
            
        detailControllerObj.className = cell.lblClass.text
        detailControllerObj.studentName = cell.lblName.text
        detailControllerObj.rollNumber = cell.lblRollNumber.text?.toInt()
            
        }
    }
    
}

