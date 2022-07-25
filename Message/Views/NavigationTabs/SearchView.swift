//
//  SearchView.swift
//  Message
//
//  Created by Matthew Titi on 6/15/22.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var model: AppStateModel
    @State var text: String = ""
    @State var usernames: [String] = []
    
    let completion: ((String) -> Void)
    
    init(completion: @escaping ((String) -> Void)) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
            TextField("Search...", text: $text)
                .modifier(CustomField())
                .cornerRadius(20)
                Spacer()
            }
            Button("Search"){
                guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }
                model.searchUsers(queryText: text) { usernames in
                    self.usernames = usernames
                }
        }
//            List {
//                ForEach(usernames, id: \.self) { name in
//                    HStack {
//                        Circle()
//                            .frame(width: 55, height: 55)
//                            .foregroundColor(Color.green)
//
//                        Text(name)
//                            .font(.system(size: 24))
//
//                        Spacer()
//                    }
//                    .onTapGesture {
//                        presentationMode.wrappedValue.dismiss()
//                        completion(name)
//                    }
//                }
//            }
       
            ScrollView{
                
            }
    }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() { _ in }
    }
}
