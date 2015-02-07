//
//  NewConcertFormViewController.swift
//  Fandom
//
//  Created by Student on 2/5/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit
import CoreData

class NewConcertFormViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var bandName: UITextField!
    @IBOutlet weak var venueName: UITextField!
    
    @IBAction func onSubmitClick(sender: UIButton) {
        self.submitForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitForm() {
        var concerts = [NSManagedObject]()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Concert", inManagedObjectContext:managedContext)
        
        let concert = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        concert.setValue(self.bandName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), forKey:"bands")
        concert.setValue(self.venueName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()), forKey:"venue")
        concert.setValue(NSDate(), forKey:"date")
        concert.setValue(0, forKey:"score")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        } else {
            // add the new concert
            concerts.append(concert)
            
            // load the stats page
            performSegueWithIdentifier("ShowStatsPage", sender: self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
        // NSLog("began editing")
    }
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
       //  NSLog("should end - %@", textField.restorationIdentifier!)
        
        /*if (textField.restorationIdentifier! == "BandName") {
            // change focus to VenueName
        }*/
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }

}
