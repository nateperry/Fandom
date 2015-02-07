//
//  ConcertViewController.swift
//  Fandom
//
//  Created by Student on 2/6/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit
import MobileCoreServices

class ConcertViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let motionData:MotionDetection = MotionDetection();
    
    override func viewWillAppear(animated: Bool) {
        //this stops accelerometer from running duplicates
        if(!motionData.motionManager.accelerometerActive){
            motionData.movement();
        }
    }
    
    //MARK: - Camera Control
    @IBAction func takePicture(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            var picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage]
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else{
            NSLog("No Camera.")
        }
    }
    
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

}
