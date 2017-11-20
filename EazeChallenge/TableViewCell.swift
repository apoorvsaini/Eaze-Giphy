//
//  TableViewCell.swift
//  EazeChallenge
//
//  Created by Appy on 11/19/17.
//  Copyright © 2017 eaze. All rights reserved.
//

import UIKit
import FLAnimatedImage

class TableViewCell: UITableViewCell {
    
    let gifImageView = FLAnimatedImageView()
    let constraint = ConstraintSheet()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubview(gifImageView)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
