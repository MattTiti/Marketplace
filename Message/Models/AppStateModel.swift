//
//  AppStateModel.swift
//  Message
//
//  Created by Matthew Titi on 6/15/22.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AppStateModel: ObservableObject {
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    @Published var showingSignIn: Bool = true
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    @Published var imageURL: String = ""
    @Published var imageURL2: String = ""
    @Published var imageURL3: String = ""
    @Published var imageURL4: String = ""
    
    let storage = Storage.storage()
    let database = Firestore.firestore()
    let auth = Auth.auth()
    
    var otherUsername = ""
    var conversationListener: ListenerRegistration?
    var chatListener: ListenerRegistration?
    
    
    init() { self.showingSignIn = Auth.auth().currentUser == nil
        
    }
}

extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        database.collection("users").getDocuments { snapshot, error in guard let usernames = snapshot?.documents.compactMap({ $0.documentID }), error == nil else {
            completion([])
            return
        }
            let filtered =  usernames.filter({ $0.lowercased().hasPrefix(queryText.lowercased())
                
            })
            completion(filtered)
        }
    }
}
extension AppStateModel {
    func getConversations() {
        conversationListener = database
            .collection("users")
            .document(currentUsername)
            .collection("chats").addSnapshotListener { [weak self] snapshot, error in
                guard let usernames = snapshot?.documents.compactMap({ $0.documentID}), error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.conversations = usernames
                    
                }
                
            }
    }
}
extension AppStateModel {
    func observeChat() {
        createConversation()
        chatListener = database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .collection("messages")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let objects = snapshot?.documents.compactMap({ $0.data()}),
                      error == nil else {
                    return
                }
                let messages: [Message] = objects.compactMap({
                    guard let date = ISO8601DateFormatter().date(from: $0["created"] as? String ?? "") else {
                        return nil
                    }
                    return Message(
                        text: $0["text"] as? String ?? "",
                        type: $0["sender"] as? String == self?.currentUsername ? .sent : .recieved,
                        created: date
                    )
                }).sorted(by: { first, second in
                    return first.created < second.created
                })
                DispatchQueue.main.async {
                    self?.messages = messages
                    
                }
                
            }
    }
    func sendMessage(text: String) {
        let newMessageId = UUID().uuidString
        let dateString = ISO8601DateFormatter().string(from: Date())
        
        guard !dateString.isEmpty else {
            return
        }
        
        let data = [
            "text": text,
            "sender": currentUsername,
            "created": dateString
        ]
        database.collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .collection("messages")
            .document(newMessageId)
            .setData(data)
        
        database.collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername)
            .collection("messages")
            .document(newMessageId)
            .setData(data)
        
    }
    func createConversation() {
        database.collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername).setData(["created":"true"])
        
        database.collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername).setData(["created":"true"])
    }
}
extension AppStateModel {
    func signIn(username: String, password: String) {
        database.collection("users").document(username).getDocument { [weak self] snapshot, error in guard let email = snapshot?.data()?["email"] as? String, error == nil else {
            return
        }
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in guard error == nil, result != nil else {
                return
            }
                DispatchQueue.main.async {
                    self?.currentEmail = email
                    self?.currentUsername = username
                    self?.showingSignIn = false
                }
                
            })
        }
    }
    func signUp(email: String, username: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in guard  result != nil, error == nil else {
            return
        }
            let data = [
                "email": email,
                "username": username
            ]
            
            self?.database
                .collection("users")
                .document(username)
                .setData(data) { error in
                    guard error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.currentUsername = username
                        self?.currentEmail = email
                        self?.showingSignIn = false
                    }
                }
        }
        
    }
    func signOut() {
        do {
            try auth.signOut()
            self.showingSignIn = true
        }
        catch {
            print(error)
        }
    }
}
extension AppStateModel {
    //    func uploadImage(image: UIImage) -> Void {
    //        let imageID = UUID().uuidString
    //        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
    //            self.imageURL = nil
    //            return
    //        }
    //
    //        let storageRef = Storage.storage().reference().child("images/\(imageID).jpg")
    //        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
    //            if let error = error {
    //                print("Error uploading image: \(error)")
    //                return
    //            }
    //
    //            storageRef.downloadURL { (url, error) in
    //                if let error = error {
    //                    print("Error getting image URL: \(error)")
    //                    return
    //                }
    //
    //                guard let url = url else {
    //                    return
    //                }
    //
    //                self.imageURL = url
    //            }
    //        }
    //    }
    func downloadAndUploadImages(image: UIImage, image2: UIImage, image3: UIImage, image4: UIImage, completion: @escaping () -> Void) {
        var counter = 0
        
        if image.size == CGSize.zero {
            // Set the imageURL to the placeholder URL
            self.imageURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
            counter += 1
            // Check if all images have been uploaded
            if counter == 4 {
                // Call the completion block
                completion()
            }
        } else {
            let imageID = UUID().uuidString
            // Convert the image to JPEG data
            guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                return
            }
            
            // Create a storage reference for the image
            let storageRef = Storage.storage().reference().child("images/\(imageID).jpg")
            
            // Upload the image data to the storage reference
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                // Get the URL of the uploaded image
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting image URL: \(error)")
                        return
                    }
                    
                    guard let url = url else {
                        return
                    }
                    self.imageURL = url.absoluteString
                    // Increment the counter
                    counter += 1
                    // Check if all images have been uploaded
                    if counter == 4 {
                        // Call the completion block
                        completion()
                    }
                }
            }
        }
        if image2.size == CGSize.zero {
            // Set the imageURL to the placeholder URL
            self.imageURL2 = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
            counter += 1
            // Check if all images have been uploaded
            if counter == 4 {
                // Call the completion block
                completion()
            }
        } else {
            let imageID2 = UUID().uuidString
            // Convert the image to JPEG data
            guard let imageData2 = image2.jpegData(compressionQuality: 0.75) else {
                return
            }
            
            // Create a storage reference for the image
            let storageRef2 = Storage.storage().reference().child("images/\(imageID2).jpg")
            
            // Upload the image data to the storage reference
            storageRef2.putData(imageData2, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                // Get the URL of the uploaded image
                storageRef2.downloadURL { (url2, error) in
                    if let error = error {
                        print("Error getting image URL: \(error)")
                        return
                    }
                    
                    guard let url2 = url2 else {
                        return
                    }
                    self.imageURL2 = url2.absoluteString
                    // Increment the counter
                    counter += 1
                    // Check if all images have been uploaded
                    if counter == 4 {
                        // Call the completion block
                        completion()
                    }
                }
            }
        }
        if image3.size == CGSize.zero {
            // Set the imageURL to the placeholder URL
            self.imageURL3 = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
            counter += 1
            // Check if all images have been uploaded
            if counter == 4 {
                // Call the completion block
                completion()
            }
        } else {
            let imageID3 = UUID().uuidString
            // Convert the image to JPEG data
            guard let imageData3 = image3.jpegData(compressionQuality: 0.75) else {
                return
            }
            
            // Create a storage reference for the image
            let storageRef3 = Storage.storage().reference().child("images/\(imageID3).jpg")
            
            // Upload the image data to the storage reference
            storageRef3.putData(imageData3, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                // Get the URL of the uploaded image
                storageRef3.downloadURL { (url3, error) in
                    if let error = error {
                        print("Error getting image URL: \(error)")
                        return
                    }
                    
                    guard let url3 = url3 else {
                        return
                    }
                    self.imageURL3 = url3.absoluteString
                    // Increment the counter
                    counter += 1
                    // Check if all images have been uploaded
                    if counter == 4 {
                        // Call the completion block
                        completion()
                    }
                }
            }
        }
        if image4.size == CGSize.zero {
            // Set the imageURL to the placeholder URL
            self.imageURL4 = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
            counter += 1
            // Check if all images have been uploaded
            if counter == 4 {
                // Call the completion block
                completion()
            }
        } else {
            let imageID4 = UUID().uuidString
            // Convert the image to JPEG data
            guard let imageData4 = image.jpegData(compressionQuality: 0.75) else {
                return
            }
            
            // Create a storage reference for the image
            let storageRef4 = Storage.storage().reference().child("images/\(imageID4).jpg")
            
            // Upload the image data to the storage reference
            storageRef4.putData(imageData4, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                // Get the URL of the uploaded image
                storageRef4.downloadURL { (url4, error) in
                    if let error = error {
                        print("Error getting image URL: \(error)")
                        return
                    }
                    
                    guard let url4 = url4 else {
                        return
                    }
                    self.imageURL4 = url4.absoluteString
                    // Increment the counter
                    counter += 1
                    // Check if all images have been uploaded
                    if counter == 4 {
                        // Call the completion block
                        completion()
                    }
                }
            }
        }
    }
    
    func getPostInfo(title: String, description: String, category: String, condition: String, size: String, price: Int, image: UIImage, image2: UIImage, image3: UIImage, image4: UIImage){
        let newPostID = UUID().uuidString
        let dateString = ISO8601DateFormatter().string(from: Date())
        
        
        guard !dateString.isEmpty else {
            return
        }
        print("\(image)")
        print("\(image2)")
        print("\(image3)")
        print("\(image4)")
        
        downloadAndUploadImages(image: image, image2: image2, image3: image3, image4: image4) {
            let data = [
                "title": title,
                "description": description,
                "category": category,
                "condition": condition,
                "size": size,
                "price": price,
                "picture": self.imageURL,
                "picture2": self.imageURL2,
                "picture3": self.imageURL3,
                "picture4": self.imageURL4,
                "created": dateString,
                "username": self.currentUsername
            ] as [String : Any]
            
            self.database.collection("items")
                .document(newPostID)
                .setData(data)
        }
    }
}

extension AppStateModel {
    func updateDocument(id: String, title: String, description: String, category: String, condition: String, size: String, price: Int) {
        let dateString = ISO8601DateFormatter().string(from: Date())
        let data = [
            "title": title,
            "description": description,
            "category": category,
            "condition": condition,
            "size": size,
            "price": price,
            "created": dateString,
            "username": self.currentUsername
        ] as [String : Any]
        
        
        self.database.collection("items").document(id).updateData(data) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}


extension AppStateModel {
    func updatePic(id: String, image: UIImage) {
        let imageID = UUID().uuidString
        
        // Convert the image to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            return
        }
        
        // Create a storage reference for the image
        let storageRef = Storage.storage().reference().child("images/\(imageID).jpg")
        
        // Upload the image data to the storage reference
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error)")
                return
            }
            
            // Get the URL of the uploaded image
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Error getting image URL: \(error)")
                    return
                }
                
                guard let url = url else {
                    return
                }
                print(url)
                print(url.absoluteString)
                
                let data = [
                    "picture": url.absoluteString,
                ] as [String : Any]
                
                
                self.database.collection("items").document(id).updateData(data) { (error) in
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
    }
}
extension AppStateModel {
    func savePost(id: String) {
        let data = [
            "id": id
        ]
        
        database.collection("users")
            .document(currentUsername)
            .collection("saved")
            .document(id)
            .setData(data)
    }
}
extension AppStateModel {
    func getSaved(completion: @escaping ([String]) -> Void) {
        var ids = [String]()
        
        database.collection("users").document(currentUsername)
            .collection("saved").getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                ids = documents.map { document in
                    let data = document.data()
                    return data["id"] as? String ?? ""
                }
                
                completion(ids)
            }
    }
    
}
extension AppStateModel {
    func deletePost(id: String) {
        database.collection("users")
            .document(id)
            .delete()
        
    }
    func unsavePost(id: String) {
        database.collection("users")
            .document(currentUsername)
            .collection("saved")
            .document(id)
            .delete()
    }
}
