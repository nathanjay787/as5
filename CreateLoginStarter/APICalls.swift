//
//  APICalls.swift
//  CreateLoginStarter
//
//  Created by Jasiukajc, Nathan on 2017-04-12.
//  Copyright © 2017 Chris. All rights reserved.
//

import Foundation

import Foundation

enum APICalls: Int {
    case allProducts = 0
    case deleteAProduct = 1
    case addProduct = 2
    case resetAPI = 3
    
    var theIndex:Int {
        get {
            return self.rawValue
        }
    }
}
