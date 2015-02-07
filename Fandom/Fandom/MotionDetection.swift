//
//  MotionDetection.swift
//  Fandom
//
//  Created by Nathaniel Kierpiec on 2/5/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit;
import CoreMotion;

class MotionDetection {
    var motionManager = CMMotionManager();
    var queue = NSOperationQueue();
    
    func movement() {
        if(motionManager.accelerometerAvailable){
            println("Accelerometer available.");
            motionManager.accelerometerUpdateInterval = 0.2;
            motionManager.startAccelerometerUpdatesToQueue(queue){ (data, error) in
                if((error) != nil){
                    println(error);
                } else {
                    println("X = \(data.acceleration.x)");
                    println("Y = \(data.acceleration.y)");
                    println("Z = \(data.acceleration.z)");
                }
            };
        } else {
            println("Accelerometer not available.");
        }
    }
}
