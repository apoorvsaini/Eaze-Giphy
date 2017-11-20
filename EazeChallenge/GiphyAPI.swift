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
    func getTrending() -> Void {
        _ = giphyClient.trending() { (response, error) in
            if (error as NSError?) != nil {
                print(error ?? "")
            }
            
            if let response = response, let data = response.data {
                print(response.meta)
                for result in data {
                    print(result.images!.downsizedLarge!.gifUrl! )
                }
            } else {
                print("No Results Found")
            }
        }

    }
    
    /*------------------------------------------------------------
     Search GIFs from GIPHY
     ------------------------------------------------------------*/
    func searchGif(query: String) -> Void {
        _ = giphyClient.search(query) { (response, error) in
            if (error as NSError?) != nil {
                print(error ?? "")
            }
            
            if let response = response, let data = response.data {
                print(response.meta)
                for result in data {
                    print(result.images!.downsizedLarge!.gifUrl! )
                }
            } else {
                print("No Results Found")
            }
        }
    }
}
