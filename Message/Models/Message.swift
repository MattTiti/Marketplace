//
//  Message.swift
//  Message
//
//  Created by Matthew Titi on 6/15/22.
//

import Foundation
import SwiftUI

enum MessageType: String {
    case sent
    case recieved
}

struct Message: Hashable {
    let text: String
    let type: MessageType
    let created: Date
}
