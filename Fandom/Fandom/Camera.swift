//
//  Camera.swift
//  Fandom
//
//  Created by Danny on 2/6/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Camera: NSObject {
    
    let captureSession = AVCaptureSession()
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    func initCamera() {
        // Do any additional setup after loading the view, typically from a nib.
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    //println(devices)
                }
            }
        }
        
        if captureDevice != nil {
            beginSession()
        }
        
    }
    
    func beginSession(){
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.parent.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
}