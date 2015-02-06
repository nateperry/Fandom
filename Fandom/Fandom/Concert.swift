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
    
    let bands = "", venue = ""
    
    init (dataSet:NSManagedObject) {
        self.bands = dataSet.valueForKey("bands") as String!
        self.venue = dataSet.valueForKey("venue") as String!
    }
}
