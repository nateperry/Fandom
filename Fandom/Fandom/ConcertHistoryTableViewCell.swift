//
//  ConcertHistoryTableViewCell.swift
//  Fandom
//
//  Created by Student on 2/6/15.
//  Copyright (c) 2015 Fandom. All rights reserved.
//

import UIKit

class ConcertHistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelBandName: UILabel!
    @IBOutlet weak var labelVenue: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelScore: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
