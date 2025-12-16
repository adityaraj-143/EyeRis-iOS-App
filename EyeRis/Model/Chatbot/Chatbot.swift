//
//  Chatbot.swift
//  EyeRis
//
//  Created by SDC-USER on 16/12/25.
//

import Foundation


enum Role {
    case user
    case bot
}

struct Message {
    var role: Role
    var text: String
    var time: Date
    var isBookmarked: Bool
}
