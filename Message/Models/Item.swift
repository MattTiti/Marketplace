//
//  Post.swift
//  Message
//
//  Created by Matthew Titi on 7/13/22.
//

import Foundation
import SwiftUI



struct Item: Identifiable, Hashable {
    var id: String
    let title: String
    let description: String
    let category: String
    let condition: String
    let size: String
    let price: Int
    let picture: URL
    let picture2: URL
    let picture3: URL
    let picture4: URL
    let created: String
    let username: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(category)
        hasher.combine(condition)
        hasher.combine(size)
        hasher.combine(price)
        hasher.combine(created)
        hasher.combine(username)
    }
    
    
    init(id: String, title: String, description: String, category: String, condition: String, size: String, price: Int, picture: URL, picture2: URL, picture3: URL, picture4: URL, created: String, username: String) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.condition = condition
        self.size = size
        self.price = price
        self.picture = picture
        self.picture2 = picture2
        self.picture3 = picture3
        self.picture4 = picture4
        self.created = created
        self.username = username
        
    }
}
