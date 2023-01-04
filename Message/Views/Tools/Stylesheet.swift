//
//  Stylesheet.swift
//  Message
//
//  Created by Matthew Titi on 7/23/22.
//

import SwiftUI

extension Image {
    func profileImageStyle() -> some View{
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 140, height: 140)
            .clipShape(Circle())
            .clipped()
            .overlay(){
                ZStack{
                    Image(systemName: "camera.fill")
                        .foregroundColor(.gray)
                        .offset(y: 60)
                    
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.white, lineWidth: 4)
                }
            }
    }
}
