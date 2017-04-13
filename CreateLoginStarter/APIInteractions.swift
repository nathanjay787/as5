//
//  APIInteractions.swift
//  CreateLoginStarter
//
//  Created by Jasiukajc, Nathan on 2017-04-12.
//  Copyright © 2017 Chris. All rights reserved.
//

import Foundation

class APIInteractions{
    class func authorizeUser(theURL: URL, onCompletion: @escaping ([String:Any]!)->Void){
        var request = URLRequest(url: theURL)
        request.httpMethod = "GET"
        let searchTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error fetching result: \(String(describing: error))")
                onCompletion(nil)
                return
            }
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                onCompletion(resultsDictionary)
            } catch {
                print("Error parsing JSON: \(error)")
                onCompletion(nil)
                return
            }
        }
        searchTask.resume()

    }
}
