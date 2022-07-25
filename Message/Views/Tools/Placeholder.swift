//
//  Placeholder.swift
//  Message
//
//  Created by Matthew Titi on 7/13/22.
//

import SwiftUI

struct Placeholder: View {
    var body: some View {
        HStack{
            Image(systemName: "")
                .font(.system(size: 25,
                              weight: .regular,
                              design: .default))
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(Color.gray)
                .cornerRadius(10)
            Image(systemName: "")
                .font(.system(size: 25,
                              weight: .regular,
                              design: .default))
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(Color.gray)
                .cornerRadius(10)
            Image(systemName: "")
                .font(.system(size: 25,
                              weight: .regular,
                              design: .default))
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(Color.gray)
                .cornerRadius(10)
            Image(systemName: "")
                .font(.system(size: 25,
                              weight: .regular,
                              design: .default))
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(Color.gray)
                .cornerRadius(10)
        }
    }
}

struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder()
    }
}
