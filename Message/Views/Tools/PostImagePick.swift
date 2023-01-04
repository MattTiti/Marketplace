//
//  PostImagePick.swift
//  Message
//
//  Created by Matthew Titi on 7/24/22.
//

import SwiftUI

extension AsyncImage {
    func postImageStyle() -> some View{
            self.font(.system(size: 25,
                          weight: .regular,
                          design: .default))
            .foregroundColor(.gray)
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 2)
            )
            }
    }

extension Image {
    func postImageStyle() -> some View{
            self.font(.system(size: 25,
                          weight: .regular,
                          design: .default))
            .foregroundColor(.gray)
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 2)
            )
            }
    }
