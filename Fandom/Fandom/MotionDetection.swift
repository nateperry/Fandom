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
    var accelX = 0.0;
    var accelY = 0.0;
    var accelZ = 0.0;
    var delta = 0.0;
    
    let motionManager = CMMotionManager();
    let queue = NSOperationQueue();
    
    //get accelerometer updates based on time interval
    func movement() -> Void {
        if(motionManager.accelerometerAvailable){
            println("Accelerometer available.");
            motionManager.accelerometerUpdateInterval = 1.5;
            motionManager.startAccelerometerUpdatesToQueue(queue){ (data, error) in
                if((error) != nil){
                    println(error);
                } else {
                    //total delta of accelerometer in all dirs
                    self.accelX = data.acceleration.x;
                    self.accelY = data.acceleration.y;
                    self.accelZ = data.acceleration.z;
                    
                    self.delta += self.accelX + self.accelY + self.accelZ;
                    
                    println("\(self.delta)");
                }
            }; //end of accelerometer updates to queue
        } else {
            println("Accelerometer not available.");
        }
    }
    
    func getDelta() -> Double {
        return abs(delta) * 100.0;
    }
}
