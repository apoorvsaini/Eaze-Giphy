//
//  StyleSheet.swift
//  EazeChallenge
//
//  Created by Apoorv on 11/19/17.
//  Copyright © 2017 eaze. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import FLAnimatedImage

class ConstraintSheet: NSObject {
    func setSearchBox(searchBox: UITextField, superview: UIView) -> Void {
        searchBox.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(superview)
            make.height.equalTo(50)
            make.centerX.equalTo(superview)
            make.topMargin.equalTo(20)
        }
    }
    
    func setContentArea(contentArea: UIView, superview: UIView) -> Void {
        contentArea.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo((superview.snp.bottom)).offset(0)
            make.right.equalTo((superview.snp.right))
            make.width.equalTo((superview.snp.width))
            make.topMargin.equalTo(70)
        }
    }
    
    func setTableArea(tableView: UITableView, superview: UIView) -> Void {
        tableView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo((superview.snp.bottom))
            make.right.equalTo((superview.snp.right))
            make.width.equalTo((superview.snp.width))
            make.topMargin.equalTo(0)
        }
    }
    
    func setGifInCell(animatedView: FLAnimatedImageView,superview: UIView) -> Void {
        animatedView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(superview)
            make.height.equalTo(20)
            make.centerX.equalTo(superview)
            make.topMargin.equalTo(0)
        }
    }
}
