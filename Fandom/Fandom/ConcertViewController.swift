//
//  ConcertViewController.swift
//  Fandom
//
//  Created by Student on 2/6/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit

class ConcertViewController: UIViewController {

    let motionData = MotionDetection();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        motionData.movement();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //grab the delta of motion in all dirs based on time interval
//    func motionDelta() -> Double {
//        let multiplier = 100.0;
//        var deltaX = motionData.accelX;
//        var deltaY = motionData.accelY;
//        var deltaZ = motionData.accelZ;
//        var totalDelta = 0.0;
//        
//        //find the change in each dir, increment based on certain multiplier
//        
//        
//        return totalDelta;
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
