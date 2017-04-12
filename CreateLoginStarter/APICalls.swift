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
    case allUsers = 0
    case userInfo = 1
    case authenticateUser = 2
    case addUser = 3
    case updateUser = 4
    case deleteUser = 5
    
    var theIndex:Int {
        get {
            return self.rawValue
        }
    }
}
