//
//  File.swift
//  Message
//
//  Created by Matthew Titi on 12/27/22.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import os.signpost

class ItemListViewModel: ObservableObject {
    @Published var items = [Item]()
    var essentials: [Item] = []
    var clothing: [Item] = []
    var shoes: [Item] = []
    var other: [Item] = []
    var saved: [Item] = []
    let model: AppStateModel
    
    let database = Firestore.firestore()
  
    
    init(model: AppStateModel) {
        let signposter = OSSignposter()
                        let signpostID = signposter.makeSignpostID()
        let state = signposter.beginInterval("download Request", id: signpostID)
        self.model = model
        database.collection("items").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            model.getSaved { savedIds in
                for item in documents.map({ document -> Item in
                    let data = document.data()
                    let id = document.documentID
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let condition = data["condition"] as? String ?? ""
                    let size = data["size"] as? String ?? ""
                    let price = data["price"] as? Int ?? 0
                    let picture = data["picture"] as? String ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                    let picture2 = data["picture2"] as? String ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                    let picture3 = data["picture3"] as? String ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                    let picture4 = data["picture4"] as? String ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                    let created = data["created"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let imageURL = URL(string: picture)!
                    let imageURL2 = URL(string: picture2)!
                    let imageURL3 = URL(string: picture3)!
                    let imageURL4 = URL(string: picture4)!
                    
                    // Download the image data from the URL
                   
                    
                    
                    return Item(id: id, title: title, description: description, category: category, condition: condition, size: size, price: price, picture: imageURL, picture2: imageURL2, picture3: imageURL3, picture4: imageURL4, created: created, username: username)
                })
                {
                    if item.category == "Essentials" {
                        self.essentials.append(item)
                    } else if item.category == "Clothing" {
                        self.clothing.append(item)
                    } else if item.category == "Shoes" {
                        self.shoes.append(item)
                    }
                    else if item.category == "Other" {
                        self.other.append(item)
                    }
                    if savedIds.contains(String(item.id)) {
                        self.saved.append(item)
                    }
                }
                self.items = self.essentials + self.clothing + self.shoes + self.other
                self.items.shuffle()
                signposter.endInterval("download Request", state)
            }
            
        }
    }
}

