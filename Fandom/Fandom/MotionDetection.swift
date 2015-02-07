//
//  MotionDetection.swift
//  Fandom
//
//  Created by Nathaniel Kierpiec on 2/5/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import Foundation
import UIKit;
import CoreMotion;

class MotionDetection {
    lazy var motionManager = CMMotionManager();
    
    func movement() {
        if(motionManager.accelerometerAvailable){
            let queue = NSOperationQueue();
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler: {(data: CMAccelerometerData!, error: NSError!) in
                println("X = \(data.acceleration.x)");
                println("Y = \(data.acceleration.y)");
                println("Z = \(data.acceleration.z)");
            });
        } else {
            println("Accelerometer not avail.");
        }
    }
}
