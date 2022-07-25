//
//  PostButton.swift
//  Message
//
//  Created by Matthew Titi on 7/14/22.
//

import SwiftUI

struct PostButton: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var category: String
    @Binding var condition: String
    @Binding var price: Int
    @Binding var image: UIImage?
    @State var presented = false

    
    @EnvironmentObject var model: AppStateModel
    
    var body: some View {
        Button(action: {
            self.getPostInfo()
            
            
        
        }, label: {
            Text("Post")
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
        model.getPostInfo(title: title, description: description, category: category, condition: condition, price: price, image: image!)

        title = ""
        description = ""
        category = ""
        condition = ""
        price = 0
        image = UIImage()
        
    }

}

