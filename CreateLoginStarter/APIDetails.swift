//
//  APIDetails.swift
//  CreateLoginStarter
//
//  Created by Jasiukajc, Nathan on 2017-04-12.
//  Copyright © 2017 Chris. All rights reserved.
//

import Foundation

class APIDetails {
    static let baseURL = "http://localhost:8080/json/"
    
    static let apiCallCompletions:[APICalls:([String])->String] = [.allUsers:{(params) in "all"},
                                                                   .userInfo:{(params) in "username/\(params[0])"},
                                                                   .authenticateUser:{(params) in "login/\(params[0])/\(params[1])"},
                                                                   .addUser:{(params) in "add"},
                                                                   .updateUser:{(params) in "\(params[0])"},
                                                                   .deleteUser:{(params) in "add"}]
    
    class func buildUrl(callType:APICalls, params:[String])->URL {
        return URL(string: baseURL+apiCallCompletions[callType]!(params))!
    }
}
