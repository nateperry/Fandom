//
//  FirstViewController.swift
//  Fandom
//
//  Created by Student on 2/5/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func selectNewConcert(sender: UIButton) {
        NSLog("hello")
        self.performSegueWithIdentifier("ShowNewConcertForm", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

