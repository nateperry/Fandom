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
    
    @IBOutlet weak var fanCountLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    //Image that gets retrieved after taken from Camera (sent over by ConcertView Controller
    var captureImg:UIImage?
    
    //Event listener - Start Camera
    @IBAction func cancelCamera(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        NSLog("Recieved Data");
    }
    
    override func viewDidAppear(animated: Bool) {
        picture.image = captureImg
        checkFaces(captureImg!)
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
        
        picture.image = UIImage(CIImage: ciimg!)
        
        /*get orientation of image taken
        var orientation:NSNumber
        switch (img.imageOrientation) {
            case UIImageOrientation.Up:
                orientation = 1;
                break;
            case UIImageOrientation.Down:
                orientation = 3;
                break;
            case UIImageOrientation.Left:
                orientation = 8;
                break;
            case UIImageOrientation.Right:
                orientation = 6;
                break;
            case UIImageOrientation.UpMirrored:
                orientation = 2;
                break;
            case UIImageOrientation.DownMirrored:
                orientation = 4;
                break;
            case UIImageOrientation.LeftMirrored:
                orientation = 5;
                break;
            case UIImageOrientation.RightMirrored:
                orientation = 7;
                break;
            default:
                break;
        }*/
        var faceTotal = 0
        
        for(var i=0; i<=8; i++){
            var ciimg:CIImage? = CIImage(CGImage: cgiimg)
            var imageOptions = NSDictionary(objects: [i], forKeys: [CIDetectorImageOrientation])
            let results = detector.featuresInImage(ciimg, options:[CIDetectorImageOrientation:i]);
            println(i)
            
            //let results:NSArray = detector.featuresInImage(ciimg);
            if results.count > 0 {
                if results.count > faceTotal {faceTotal = results.count} //will take in the results with most faces found
                
                NSLog("I FOUND %i FACES", results.count)
                for r in results {
                    let face = r as CIFaceFeature
                    NSLog("Face found at (%f,%f) of dimensions %fx%f", face.bounds.origin.x, face.bounds.origin.y, face.bounds.width, face.bounds.height)
                }
            }
            else {
                NSLog("NO FACE DUDE")
            }
        }
        
        updatePoints(faceTotal)
        
        
    }//end
    
    func updatePoints(faces:Int){
        
    }
    
}