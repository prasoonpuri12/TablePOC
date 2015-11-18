//
//  RootViewController.swift
//  TableViewPOC
//
//  Created by Prasoon Puri on 10/29/15.
//  Copyright (c) 2015 Prasoon Puri. All rights reserved.
//

import UIKit
import CoreData

class RootViewController: UIViewController {
    
    let appdelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var txtDate: UITextField!

    @IBOutlet weak var calendar: UIDatePicker!
    @IBOutlet weak var txtRollNumber: UITextField!
    @IBOutlet weak var txtClass: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.hidden = true
        calendar.datePickerMode = UIDatePickerMode.Date
    }
    
    override func viewDidAppear(animated: Bool) {
        self.txtClass.text = ""
        self.txtName.text = ""
        self.txtRollNumber.text = ""
    }

    @IBAction func openCalendar(sender: AnyObject) {
        txtName.resignFirstResponder()
        txtClass.resignFirstResponder()
        txtRollNumber.resignFirstResponder()
        txtDate.resignFirstResponder()
        if(!self.calendar.hidden)
        {
            self.calendar.hidden = true
        }else
        {
            self.calendar.hidden = false
        }
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var strDate = dateFormatter.stringFromDate(calendar.date)
        self.txtDate.text = strDate
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addRecordInArray()
    {
               
        self.saveProfileToDatabase(self.txtName.text , className: self.txtClass.text , rollNumber: self.txtRollNumber.text.toInt()!)
        
        self.fetchManagedObjectFromDatabase()
    }
    
    func checkEmptyFields()->Bool
    {
        if self.txtName.text == "" || self.txtClass.text == "" || self.txtRollNumber.text == "" {
            
            let alertController = UIAlertController(title: "Alert!!", message: "Please fill the required field", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler:nil))
            self.presentViewController(alertController, animated:true, completion:nil)
            return false
            
        } else {
            
            return true
        }
    }
    
    func fetchManagedObjectFromDatabase()
    {
        let managedcontext : NSManagedObjectContext = self.appdelegate.managedObjectContext!
        
        var fetch : NSFetchRequest = NSFetchRequest(entityName:"Student")
        
        var fetchedResult = managedcontext.executeFetchRequest(fetch, error:nil)
        
        Profile.recordArrayDOB =  fetchedResult as! [NSManagedObject]
    }
    
    
    
    func saveProfileToDatabase(var studentName : String , var className : String , var rollNumber : Int)
    {
        var errorPointer : NSErrorPointer = nil
        
        let managedcontext : NSManagedObjectContext = self.appdelegate.managedObjectContext!
        
        var entityDescription = NSEntityDescription.entityForName("Student", inManagedObjectContext:(managedcontext))
        
        var newPerson = NSManagedObject(entity:entityDescription!, insertIntoManagedObjectContext:(managedcontext))
        
        newPerson.setValue(className, forKey:"classname")
        newPerson.setValue(studentName, forKey:"studentname")
        newPerson.setValue(rollNumber, forKey:"rollnumber")
        if((newPerson.managedObjectContext?.save(errorPointer)) == nil )
        {
            println("Unable to find ManagedObjectContext")
            println("ERROR : ",errorPointer.debugDescription)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(checkEmptyFields() == true) {
            
            self.addRecordInArray()
        }
        
        if(segue.identifier == "showRecord") {
            
            var tableViewControllerObj = segue.destinationViewController as! TableViewController
        }
        
        
    }
    

}
