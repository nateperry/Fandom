//
//  ConcertViewController.swift
//  Fandom
//
//  Created by Student on 2/6/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary

class ConcertViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let motionData:MotionDetection = MotionDetection();
    
    var fireScoreUpdate = NSTimer();
    var firstInterval: Int = 0;
    var secondInterval: Int = 0;
    var total: Int = 0;
    var delta: Int = 0;
    
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var buttonStartMotion: UIButton!
    @IBOutlet weak var buttonStopMotion: UIButton!
    
    @IBAction func toggleStartMotion(sender: AnyObject) {
        //start - IFF the accelerometer is not running
        if(buttonStartMotion.titleLabel?.text == "Start") {
            if(!motionData.motionManager.accelerometerActive) {
                motionData.movement();
            }
            buttonStartMotion.setTitle("Pause", forState: UIControlState.Normal);
        } else {
            motionData.motionManager.stopAccelerometerUpdates();
            buttonStartMotion.setTitle("Start", forState: UIControlState.Normal);
        }
    }
    
    @IBAction func toggleStopMotion(sender: AnyObject) {
        motionData.motionManager.stopAccelerometerUpdates();
        
        buttonStartMotion.userInteractionEnabled = false;
        buttonStartMotion.alpha = 0.4;
    }
    
    /*
    // MARK: - Access Camera
    */
    @IBAction func takePicture(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            var picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage]
            picker.allowsEditing = false
            picker.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else{
            NSLog("No Camera.")
        }
    }
    
    // < 20   : X 0
    //20 - 40 : x 1
    //40 - 60 : x 2
    // > 60   : x 3
    func updateScore() {
        secondInterval = Int(motionData.getDelta());
        //should only trigger once!
        if(firstInterval == 0) {
            total = total + (secondInterval * 3);
        } else {
            delta = abs(secondInterval - firstInterval);
            if(delta < 2) {
                //movement is either very small or non existent, do nothing...
            } else if(delta > 2 && delta < 4) {
                total = total + (secondInterval);
            } else if(delta > 4 && delta < 6) {
                total = total + (secondInterval * 2);
            } else if(delta > 6) {
                total = total + (secondInterval * 3);
            }
        }
        firstInterval = secondInterval;
        labelScore.text = "\(total)";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fireScoreUpdate = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateScore"), userInfo: nil, repeats: true);
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
    
    
    /*
    // MARK: - Camera Delegate Methods
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary!) {
        NSLog("Received image from camera")
        let mediaType = info[UIImagePickerControllerMediaType] as String
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
        let compResult:CFComparisonResult = CFStringCompare(mediaType as NSString!, kUTTypeImage, CFStringCompareFlags.CompareCaseInsensitive)
        if ( compResult == CFComparisonResult.CompareEqualTo ) {
            
            originalImage = info[UIImagePickerControllerOriginalImage] as UIImage?

            imageToSave = originalImage
            //imgView.image = imageToSave
            //imgView.reloadInputViews()
        }
        
        //Send image to PictureView to take care of adding points
        var pictureView = self.storyboard?.instantiateViewControllerWithIdentifier("PictureView") as PictureViewController
        pictureView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.presentViewController(pictureView, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}
