//
//  ConcertReviewViewController.swift
//  Fandom
//
//  Created by Student on 2/8/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit

class ConcertReviewViewController: UIViewController {
    
    var concert:Concert!

    @IBOutlet weak var labelBands: UILabel!
    @IBOutlet weak var labelVenue: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelBands.text = concert.bands
        labelVenue.text = concert.venue
        labelDate.text = concert.date

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
