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
    
    static let apiCallCompletions:[APICalls:([String])->String] = [.allProducts:{(params) in "products/all"},
                                                                   .deleteAProduct:{(params) in "products/delete/\(params[0])"},
                                                                   .addProduct:{(params) in "products/add"},
                                                                   .resetAPI:{(params) in "/products/reset"}]
    
    class func buildUrl(callType:APICalls, params:[String])->URL {
        return URL(string: baseURL+apiCallCompletions[callType]!(params))!
    }
}
