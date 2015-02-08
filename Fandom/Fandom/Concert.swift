//
//  Concert.swift
//  Fandom
//
//  Created by Student on 2/6/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit
import CoreData

class Concert: NSObject {
    
    let bands = "", venue = "", date = "", score = 0
    
    init (dataSet:NSManagedObject) {
        self.bands = dataSet.valueForKey("bands") as String!
        self.venue = dataSet.valueForKey("venue") as String!
        self.score = dataSet.valueForKey("score") as Int!
        
        // format the date
        var theDate = dataSet.valueForKey("date") as NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        self.date = dateFormatter.stringFromDate(NSDate())
    }
}
