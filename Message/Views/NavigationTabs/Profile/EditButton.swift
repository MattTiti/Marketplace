//
//  EditButton.swift
//  Message
//
//  Created by Matthew Titi on 12/29/22.
//

import SwiftUI

struct EditButton: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var category: String
    @Binding var condition: String
    @Binding var size: String
    @Binding var id: String
    @Binding var price: Int
    @Binding var image: UIImage?
    @Binding var isActive: Bool
    @Binding var showAlert: Bool

    @EnvironmentObject var model: AppStateModel
    
    var body: some View {
        Button(action: {
            self.getPostInfo()
            showAlert = true
        }, label: {
            Text("Save Changes")
                .foregroundColor(.white)
                .frame(width: 120, height: 60)
                .background(Color.blue)
                .cornerRadius(30)
                .padding()
                .frame(width: 100, height: 100, alignment: .center)
        })

        
       
    }
    func getPostInfo() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        model.updateDocument(id: id, title: title, description: description, category: category, condition: condition, size: size, price: price)
        model.updatePic(id: id, image: image ?? UIImage())
    }

}

