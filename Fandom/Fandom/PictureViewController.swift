//
//  PictureViewController.swift
//  Fandom
//
//  Created by Danny on 2/7/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import Foundation
import UIKit

class PictureViewController: UIViewController,UIImagePickerControllerDelegate{
    
    //Event listener - Start Camera
    @IBAction func cancelCamera(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    
}