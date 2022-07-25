//
//  Post.swift
//  Message
//
//  Created by Matthew Titi on 7/13/22.
//

import Foundation
import SwiftUI



struct Post: Hashable {
    let title: String
    let description: String
    let category: String
    let condition: String
    let price: String
    let created: Date
}
