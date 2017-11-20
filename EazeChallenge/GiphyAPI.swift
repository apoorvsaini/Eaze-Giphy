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
    var giphyClient = GPHClient(apiKey: "")
    
    override init() {
        if let path = Bundle.main.path(forResource: "Strings", ofType: "plist") {
            stringKeys = NSDictionary(contentsOfFile: path)
        }
        apiKey = (stringKeys!["GIPHY_API_KEY"] as? String)!
        giphyClient = GPHClient(apiKey: apiKey)
    }
    
    /*------------------------------------------------------------
     Get trending GIFs from GIPHY
     ------------------------------------------------------------*/
    func getTrending(completionHandler: @escaping (_ : NSMutableArray) -> ()) {
        let trendingResult = NSMutableArray()
        _ = giphyClient.trending() { (response, error) in
            if (error as NSError?) != nil {
                print(error ?? "")
            }
            if let response = response, let data = response.data {
                for result in data {
                    trendingResult.add(result.images!.fixedWidth!.gifUrl!)
                }
                completionHandler(trendingResult)
            }
        }
    }
    
    /*------------------------------------------------------------
     Search GIFs from GIPHY
     ------------------------------------------------------------*/
    func searchGif(query: String, completionHandler: @escaping (_ : NSMutableArray) -> ()) {
        let searchResult = NSMutableArray()
        _ = giphyClient.search(query) { (response, error) in
            if (error as NSError?) != nil {
                print(error ?? "")
            }
            if let response = response, let data = response.data {
                for result in data {
                    searchResult.add(result.images!.fixedWidth!.gifUrl!)
                }
                completionHandler(searchResult)
            }
        }
    }
}
