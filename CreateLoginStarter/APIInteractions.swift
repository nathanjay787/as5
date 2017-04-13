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
    
    class func addAccount(passWord:String, userName:String, email:String, theURL:URL, onCompletion: @escaping ([String:Any]!)->Void) {
        var request = URLRequest(url: theURL)
        request.httpMethod = "POST"
        
        request.httpBody = buildAddPostDataString(passWord: passWord, userName: userName, email: email).data(using: .utf8)
        
        let searchTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error Adding Account: \(String(describing: error))")
                onCompletion(nil)
                return
            }
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                onCompletion(resultsDictionary!)
            } catch {
                print("Error parsing JSON: \(error)")
                onCompletion(nil)
                return
            }
        }
        searchTask.resume()
    }
    
    class func buildAddPostDataString(passWord:String, userName:String, email:String) -> String {
        return "username=\(userName)&password=\(passWord)&email=\(email)"
    }
}
