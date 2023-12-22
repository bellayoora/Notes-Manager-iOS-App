//
//  User.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import Foundation

struct User: Codable {
    var _id: String?
    var name: String?
    var email: String?
    var __v: Int?
    
    init(id: String? = nil, username: String? = nil, email: String? = nil, v: Int? = nil) {
        self._id = id
        self.name = username
        self.email = email
        self.__v = v
    }
}
