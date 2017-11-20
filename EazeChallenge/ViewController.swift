//
//  ViewController.swift
//  EazeChallenge
//
//  Created by Apoorv on 11/18/17.
//  Copyright © 2017 eaze. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var contentArea = UIView()
    lazy var searchBox = UITextField()
    lazy var tableView = UITableView()
    var stringKeys: NSDictionary?
    private let myArray: NSArray = ["First","Second","Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let constraint = ConstraintSheet()
        let superview = self.view
        superview?.backgroundColor = UIColor.black
        if let path = Bundle.main.path(forResource: "Strings", ofType: "plist") {
            stringKeys = NSDictionary(contentsOfFile: path)
        }
        /*---------------------------------------------------------
         Create the search text field
        ---------------------------------------------------------*/
        superview?.addSubview(searchBox)
        searchBox.textAlignment = NSTextAlignment.center
        searchBox.backgroundColor = UIColor.black
        searchBox.textColor = UIColor.white
        searchBox.attributedPlaceholder = NSAttributedString(string: (stringKeys!["search_prompt"] as? String)!,attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
        constraint.setSearchBox(searchBox: searchBox, superview: superview!)
        
        /*---------------------------------------------------------
         Create the view holder
        ----------------------------------------------------------*/
        superview?.addSubview(contentArea)
        contentArea.backgroundColor = UIColor.white
        constraint.setContentArea(contentArea: contentArea,superview: superview!)
        
        /*---------------------------------------------------------
         Create the Table View for search results
        ----------------------------------------------------------*/
        contentArea.addSubview(tableView)
        tableView.separatorColor = UIColor.clear
        constraint.setTableArea(tableView: tableView,superview: contentArea)
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: (stringKeys!["cell_identifier"] as? String)!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (stringKeys!["cell_identifier"] as? String)!, for: indexPath) as! TableViewCell

        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

