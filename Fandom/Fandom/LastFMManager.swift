//
//  LastFMManager.swift
//  Fandom
//
//  Created by Danny on 2/5/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import Foundation
import CoreLocation

class LASTFMManager: NSObject,CLLocationManagerDelegate{
    
    let url = "http://ws.audioscrobbler.com/2.0/?method=geo.getevents&api_key=5ddef314c4eb3b9c765d9024ca581b26&format=json"
    
    var locationManager: CLLocationManager!
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var mylocation:CLLocation?
    
    /*---------------------------------------------------------------------------------------/
     getConcerts: gets the concert data from LASTFM API
    /---------------------------------------------------------------------------------------*/
    func getConcerts(location:String? = nil){
        
        var urlPath:String
        initLocationManager()
        //if a location is passed in, use that location
        //else use the user's current location
        /*
        if let unwrap_location = location {
            urlPath = url + "&location=" + location!
        }
        else{
            initLocationManager()
            var lat = mylocation!.coordinate.latitude.hashValue
            var long = mylocation!.coordinate.longitude.hashValue
            urlPath = url + "&lat=" + String(UInt8(lat)) + "&long=" + String(UInt8(long))
        }

        
        // create a session object
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        // make a network request for a URL, in this case our endpoint
        session.dataTaskWithURL(NSURL(string: url)!,
            completionHandler: { (data, response, error) -> Void in
                
                // create an NSArray with the JSON response data
                var jsonReadError:NSError?
                
                println(NSString(data: data, encoding: NSUTF8StringEncoding))
                //let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonReadError) as [AnyObject]
                
        }).resume() 
*/
    }
    
    //Send query to API
    func sendAPICall(url:String){
        
        // create a session object
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        // make a network request for a URL, in this case our endpoint
        session.dataTaskWithURL(NSURL(string: url)!,
            completionHandler: { (data, response, error) -> Void in
                
                // create an NSArray with the JSON response data
                var jsonReadError:NSError?
                
                println(NSString(data: data, encoding: NSUTF8StringEncoding))
                //let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonReadError) as [AnyObject]
                
        }).resume()
    }
    
    
    // CLLOCATION MANAGER PROTOCOL
    // Location Manager helper stuff
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
    }
    
    // Location Manager Delegate stuff
    // If failed
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    //ON FINISH QUERY CALL
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as CLLocation
            var coord = locationObj.coordinate
            
            println(coord.latitude)
            println(coord.longitude)
            //set mylocation to locationObj 's properties
            //call query
           
            var lat = coord.latitude
            var long = coord.longitude
            var urlPath = url + "&lat=" + String(UInt8(lat)) + "&long=" + String(UInt8(long))
            sendAPICall(urlPath)
            
            
        }
    }

    // authorization status
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }
}
