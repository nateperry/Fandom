//
//  NewConcertFormViewController.swift
//  Fandom
//
//  Created by Student on 2/5/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit

class NewConcertFormViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var bandName: UITextField!
    @IBOutlet weak var venueName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        NSLog("began editing")
    }
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        NSLog("should end")
        
        // if text field has id VenuaName, submit
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }

}
