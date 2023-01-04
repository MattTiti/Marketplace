//
//  ChatView.swift
//  Message
//
//  Created by Matthew Titi on 6/15/22.
//

import SwiftUI



struct CustomField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(7)
    }
}

struct ChatView: View {
    @State var message: String = ""
    @Binding var messageUsername: String
    @EnvironmentObject var model: AppStateModel
    let otherUsername: String
    init(otherUsername: String, messageUsername: Binding<String>) {
        self.otherUsername = otherUsername
        self._messageUsername = messageUsername
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(model.messages, id: \.self) {
                    message in ChatRow(text: message.text ,type: message.type)
                }
            }
            HStack{
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                
                SendButton(text: $message)
                
            }
            .padding()
            
            
        }
        .navigationBarTitle(otherUsername, displayMode: .inline)
        .onAppear() {
            model.otherUsername = otherUsername
            model.observeChat()
        }
        .onDisappear() {
            messageUsername = ""

        }
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView(otherUsername: "Fawad")
//            .preferredColorScheme(.dark)
//    }
//}
