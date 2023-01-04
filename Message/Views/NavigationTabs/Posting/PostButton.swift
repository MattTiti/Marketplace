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
    @Binding var size: String
    @Binding var price: Int
    @Binding var image: UIImage?
    @Binding var image2: UIImage?
    @Binding var image3: UIImage?
    @Binding var image4: UIImage?
    @Binding var selectedIndex: Int

    
    @EnvironmentObject var model: AppStateModel
    
    var body: some View {
        Button(action: {
            self.getPostInfo()
            selectedIndex = 5
        
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
        model.getPostInfo(title: title, description: description, category: category, condition: condition, size: size, price: price, image: image ?? UIImage(), image2: image2 ?? UIImage(), image3: image3 ?? UIImage(), image4: image4 ?? UIImage())
    
      
    }

}

