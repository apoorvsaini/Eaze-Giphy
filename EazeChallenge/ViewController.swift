//
//  ViewController.swift
//  EazeChallenge
//
//  Created by Apoorv on 11/18/17.
//  Copyright © 2017 eaze. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var contentArea = UIView()
    lazy var searchBox = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        let constraint = ConstraintSheet()
        let superview = self.view
        superview?.backgroundColor = UIColor.black
        
        /*-------------------------------
         Create the search text field
         ---------------------------------*/
        superview?.addSubview(searchBox)
        searchBox.textAlignment = NSTextAlignment.center
        searchBox.backgroundColor = UIColor.black
        searchBox.textColor = UIColor.white
        searchBox.attributedPlaceholder = NSAttributedString(string: "SEARCH A GIF",attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
        constraint.setSearchBox(searchBox: searchBox, superview: superview!)
        
        /*-------------------------------
         Create the view holder
         ---------------------------------*/
        superview?.addSubview(contentArea)
        contentArea.backgroundColor = UIColor.white
        constraint.setContentArea(contentArea: contentArea,superview: superview!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

