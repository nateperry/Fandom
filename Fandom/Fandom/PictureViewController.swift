//
//  PictureViewController.swift
//  Fandom
//
//  Created by Danny on 2/7/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import Foundation
import UIKit
import CoreImage
import ImageIO
import QuartzCore

class PictureViewController: UIViewController,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var multiplierLabel: UILabel!
    @IBOutlet weak var fanCountLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    //Image that gets retrieved after taken from Camera (sent over by ConcertView Controller
    var captureImg:UIImage?
    
    var totalscore:Int = 0
    
    //Event listener - Start Camera
    @IBAction func cancelCamera(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.sendNotification()
        })
    }
    
    func sendNotification(){
        var notifcenter:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        var dict = Dictionary<String, Int>()
        dict["score"] = totalscore
        notifcenter.postNotificationName("kPictureNotification", object: self, userInfo: dict)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        NSLog("Recieved Data");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Visuals */
        configVisuals()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.pointsLabel.alpha = 1
            }, completion: nil)
        
        checkFaces(captureImg!)
    }
    
    
    func configVisuals(){
        //picture
        picture.image = captureImg
        
        //label
        pointsLabel.alpha = 0;
        
        //button
        doneBtn.layer.borderColor = UIColor.whiteColor().CGColor
        doneBtn.layer.cornerRadius = 15;
    }
    
    
    // MARK: - Face Detection
    func checkFaces(img:UIImage){
        /* SORRY FOR THE MESS */
        
        //create detector
        let detector:CIDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        //convert the UIImage to CIImage
        println("converting")
        var context = CIContext(options: nil)
        var cgiimg = img.CGImage
        //var ciimg:CIImage? = CIImage(CGImage: cgiimg)
        var ciimg:CIImage? = CIImage(CGImage: cgiimg)
        println("done converting")
        
        var faceTotal = 0
        
        //for(var i=6; i<=8; i++){
            //var imageOptions = NSDictionary(objects: [i], forKeys: [CIDetectorImageOrientation])
            let results = detector.featuresInImage(ciimg, options:[CIDetectorImageOrientation:6]);
            //println(i)
            
            //let results:NSArray = detector.featuresInImage(ciimg);
            if results.count > 0 {
                if results.count > faceTotal {faceTotal = results.count} //will take in the results with most faces found
                
                //NSLog("I FOUND %i FACES", results.count)
                for r in results {
                    let face = r as CIFaceFeature
                    //NSLog("Face found at (%f,%f) of dimensions %fx%f", face.bounds.origin.x, face.bounds.origin.y, face.bounds.width, face.bounds.height)
                    println("Face found at \(face.bounds.origin.x), \(face.bounds.origin.y), with size \(face.bounds.size.height), \(face.bounds.size.width)")
                }
            }
            else {
                //NSLog("NO FACE DUDE")
            }
        //}
        
        updatePoints(faceTotal)
        
        
    }//end
    
    func updatePoints(faces:Int){
        var count = String(faces)
        fanCountLabel.text = "Fan Count: " + count
        
        var score = 1000*faces
        totalscore = score
        
        if faces > 1{
            multiplierLabel.text = "x" + count
        
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.multiplierLabel.alpha = 0.0
            
                UIView.animateWithDuration(1.0, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.pointsLabel.text = "+"+String(score)
                }, completion: nil)
            }, completion: nil)
        }
    }
    
}