//
//  Notes.swift
//  Bella Chen WA7
//
//  Created by Yao Chen on 11/6/23.
//

import Foundation

struct Note: Codable {
    let note: String
}

struct ReceivedNote: Codable {
    var _id: String
    var userId: String
    var text: String
    var __v: Int
    
    init(id: String, userid: String, note: String, v: Int) {
        self._id = id
        self.userId = userid
        self.text = note
        self.__v = v
    }
}

struct Notes: Codable {
    let notes: [ReceivedNote]
}
