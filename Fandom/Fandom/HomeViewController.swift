//
//  FirstViewController.swift
//  Fandom
//
//  Created by Student on 2/5/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var concertBtn: UIButton!
    @IBAction func selectNewConcert(sender: UIButton) {
        // load the form page
        self.performSegueWithIdentifier("ShowNewConcertForm", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configVisuals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configVisuals(){
        concertBtn.layer.cornerRadius = 20
        concertBtn.layer.borderColor = UIColor.orangeColor().CGColor;
        concertBtn.layer.borderWidth = 1
    }
    


}

