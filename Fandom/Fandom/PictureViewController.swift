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

class PictureViewController: UIViewController,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var picture: UIImageView!
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
    }
    
}