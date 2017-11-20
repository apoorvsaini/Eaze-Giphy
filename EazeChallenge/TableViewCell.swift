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
    
    let constraint = ConstraintSheet()
    let padding: CGFloat = 5
    let screenSize: CGRect = UIScreen.main.bounds
    var backGroundColor = UIColor()
    var gifImageView = FLAnimatedImageView()
    var backGround = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backGroundColor = UIColor.black
        selectionStyle = .none
        
        backGround = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 300))
        backGround.backgroundColor = backGroundColor
        contentView.addSubview(backGround)
        
        gifImageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 300)
        contentView.addSubview(gifImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
