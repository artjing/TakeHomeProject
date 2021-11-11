//
//  User.swift
//  UserTest
//
//  Created by 董静 on 11/5/21.
//

import Foundation

struct User: Codable{
    var createdAt: String
    var name: String
    var avatar: String
    var assets:[String]
    var id: String
}
