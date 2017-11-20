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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let constraint = ConstraintSheet()
    let screenSize: CGRect = UIScreen.main.bounds
    lazy var contentArea = UIView()
    lazy var infoBox = UIView()
    lazy var infoText = UILabel()
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
        superview?.backgroundColor = UIColor.yellow
        if let path = Bundle.main.path(forResource: "Strings", ofType: "plist") {
            stringKeys = NSDictionary(contentsOfFile: path)
        }
        
        // Setup the UI components
        createSearchBox(superview: superview!)
        createViewHolder(superview: superview!)
        createTableView(contentArea: contentArea)
        createInfoBox(superview: superview!)
        
        // Show trending GIFs on start up
        setInfoText(text: (stringKeys!["SEARCHING"] as? String)!)
        giphy.getTrending {
            gif in self.gifArray = gif
            DispatchQueue.main.async{
                self.setInfoText(text: (self.stringKeys!["TRENDING"] as? String)!)
                self.tableView.reloadData()
                self.tableView.setContentOffset(CGPoint.zero, animated: true)
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
        searchBox.delegate = self
        searchBox.textAlignment = NSTextAlignment.center
        searchBox.backgroundColor = UIColor.yellow
        searchBox.textColor = UIColor.black
        searchBox.returnKeyType = .search
        searchBox.clearButtonMode = .whileEditing
        searchBox.attributedPlaceholder = NSAttributedString(string: (stringKeys!["SEARCH_PROMPT"] as? String)!,attributes:[NSAttributedStringKey.foregroundColor: UIColor.black])
        constraint.setSearchBox(searchBox: searchBox, superview: superview)
    }
    
    func createInfoBox(superview: UIView) {
        superview.addSubview(infoBox)
        infoBox.backgroundColor = UIColor.yellow
        infoBox.layer.cornerRadius = 15
        constraint.setInfoBox(infoBox: infoBox, superview: superview)
        //setInfoText(text: (stringKeys!["TRENDING"] as? String)!)
    }
    
    func setInfoText(text: String) {
        if text.isEmpty {
            infoBox.isHidden = true
        }
        else {
            infoBox.isHidden = false
            infoText.backgroundColor = UIColor.clear
            infoText.textColor = UIColor.black
            infoText.text = text
            infoText.font = infoText.font.withSize(12)
            infoText.textAlignment = .center
            infoBox.addSubview(infoText)
            constraint.setInfoText(infoText: infoText, superview: infoBox)
        }
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        startSearching()
        return false
    }
    
    func startSearching () {
        if !searchBox.text!.isEmpty {
            setInfoText(text: (stringKeys!["SEARCHING"] as? String)!)
            giphy.searchGif(query: searchBox.text!, completionHandler: {
                gif in self.gifArray = gif
                DispatchQueue.main.async{
                    if self.gifArray.count > 0 {
                        // Hide the infoBox
                        self.setInfoText(text: "")
                    }
                    else {
                        self.setInfoText(text: (self.stringKeys!["NOTHING_FOUND"] as? String)!)
                    }
                    
                    // Reload the data
                    self.tableView.reloadData()
                    self.tableView.setContentOffset(CGPoint.zero, animated: true)
                }
            })
        }
    }
    
    /*------------------------------------------------------------
     UITableView delegate methods
    ------------------------------------------------------------*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath.row)")
        
        // Share the GIF
        var shareText = "Check out this GIF "
        shareText.append(gifArray[indexPath.row] as! String)
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        present(vc, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (stringKeys!["CELL_IDENTIFIER"] as? String)!, for: indexPath) as! TableViewCell
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

