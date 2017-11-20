//
//  GiphyAPI.swift
//  EazeChallenge
//
//  Created by Appy on 11/19/17.
//  Copyright © 2017 eaze. All rights reserved.
//

import UIKit
import GiphyCoreSDK

class GiphyAPI: NSObject {
    var stringKeys: NSDictionary?
    var apiKey = String()
    
    override init() {
        if let path = Bundle.main.path(forResource: "Strings", ofType: "plist") {
            stringKeys = NSDictionary(contentsOfFile: path)
        }
        apiKey = (stringKeys!["GIPHY_API_KEY"] as? String)!
    }
    
    func getKey() -> String {
        return apiKey
    }
    
}
