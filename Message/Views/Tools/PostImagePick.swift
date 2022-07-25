//
//  PostImagePick.swift
//  Message
//
//  Created by Matthew Titi on 7/24/22.
//

import SwiftUI

extension Image {
    func postImageStyle() -> some View{
            self.font(.system(size: 25,
                          weight: .regular,
                          design: .default))
            .foregroundColor(.white)
            .frame(width: 60, height: 60)
            .background(Color.gray)
            .cornerRadius(10)
            }
    }

