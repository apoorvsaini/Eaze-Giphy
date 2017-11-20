//
//  ViewController.swift
//  EazeChallenge
//
//  Created by Apoorv on 11/18/17.
//  Copyright © 2017 eaze. All rights reserved.
//

import UIKit
import SnapKit
import FLAnimatedImage
import PINRemoteImage
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let constraint = ConstraintSheet()
    let screenSize: CGRect = UIScreen.main.bounds
    lazy var contentArea = UIView()
    lazy var searchBox = UITextField()
    lazy var tableView = UITableView()
    var stringKeys: NSDictionary?
    var giphy = GiphyAPI()
    var gifArray: NSMutableArray = NSMutableArray()
    
    /*------------------------------------------------------------
     Initial and default View handling
     ------------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        let superview = self.view
        superview?.backgroundColor = UIColor.black
        if let path = Bundle.main.path(forResource: "Strings", ofType: "plist") {
            stringKeys = NSDictionary(contentsOfFile: path)
        }
        
        // Setup the UI components
        createSearchBox(superview: superview!)
        createViewHolder(superview: superview!)
        createTableView(contentArea: contentArea)
        searchBox.addTarget(self, action: #selector(searchBoxTextChanged(_:)), for: .editingChanged)
        
        // Show trending GIFs on start up
        giphy.getTrending {
            gif in self.gifArray = gif
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*------------------------------------------------------------
     Custom UI component functions
     ------------------------------------------------------------*/
    func createSearchBox(superview: UIView) {
        superview.addSubview(searchBox)
        searchBox.becomeFirstResponder()
        searchBox.textAlignment = NSTextAlignment.center
        searchBox.backgroundColor = UIColor.black
        searchBox.textColor = UIColor.white
        searchBox.attributedPlaceholder = NSAttributedString(string: (stringKeys!["SEARCH_PROMPT"] as? String)!,attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
        constraint.setSearchBox(searchBox: searchBox, superview: superview)
    }

    func createViewHolder(superview: UIView) {
        superview.addSubview(contentArea)
        contentArea.backgroundColor = UIColor.white
        constraint.setContentArea(contentArea: contentArea,superview: superview)
    }
    
    func createTableView(contentArea: UIView) {
        contentArea.addSubview(tableView)
        tableView.separatorColor = UIColor.clear
        constraint.setTableArea(tableView: tableView,superview: contentArea)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 300
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: (stringKeys!["CELL_IDENTIFIER"] as? String)!)
    }
    
    @objc func searchBoxTextChanged(_ textField: UITextField) {
        print(textField.text!)
    }
    
    /*------------------------------------------------------------
     UITableView delegate methods
    ------------------------------------------------------------*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (stringKeys!["CELL_IDENTIFIER"] as? String)!, for: indexPath) as! TableViewCell
        print(tableView.indexPathsForVisibleRows!)
        print(indexPath)
        cell.gifImageView.sd_setImage(with: URL(string: gifArray[indexPath.row] as! String))
        cell.gifImageView.sd_setShowActivityIndicatorView(true)
        print(gifArray[indexPath.row] as! String)
        if tableView.indexPathsForVisibleRows!.contains(indexPath) {
            cell.gifImageView.startAnimating()
        }
        else {
            cell.gifImageView.stopAnimating()
        }
        return cell
    }
}

