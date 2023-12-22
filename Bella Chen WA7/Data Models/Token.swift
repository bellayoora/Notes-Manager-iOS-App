//
//  Token.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import Foundation

struct Authentication: Codable {
    var auth: Bool
    var token: String
    
    init(auth: Bool, token: String) {
        self.auth = auth
        self.token = token
    }
}
