//
//  SendButton.swift
//  Message
//
//  Created by Matthew Titi on 6/15/22.
//

import SwiftUI

struct SendButton: View {
    @Binding var text: String
    @EnvironmentObject var model: AppStateModel
    var body: some View {
        Button(action: {
            self.sendMessage()
        }, label: {
            Image(systemName: "paperplane")
                
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 33))
                .font(.system(size: 22))
                .frame(width: 55, height: 55)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Circle())
        })
    }
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        model.sendMessage(text: text)
        
        text = ""
    }
}


