//
//  ContentView.swift
//  Message
//
//  Created by Matthew Titi on 6/15/22.
//

import SwiftUI

struct ConversationListView: View {
        
    @EnvironmentObject var model: AppStateModel
    @State var otherUsername: String = ""
    @State var showChat = false
    @State var showSearch = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(model.conversations, id: \.self) { name in NavigationLink(destination: ChatView(otherUsername: name), label: {
                    HStack{
                        Circle()
                            .frame(width: 65, height: 65)
                            .foregroundColor(Color.pink)
                        Text(name)
                            .bold()
                            .foregroundColor(Color(.label))
                            .font(.system(size: 32))
                        Spacer()
                    }
                    .padding()
                    
                })
                }
                if !otherUsername.isEmpty {
                    NavigationLink("",
                                   destination: ChatView(otherUsername: otherUsername),
                                   isActive: $showChat)
                }
            }
            .navigationTitle("Conversations")
//            .toolbar {
//                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) { Button("Sign Out") {
//                    self.signOut()
//                }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(
//                        destination: SearchView { name in
//                            self.showSearch = false
//                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//                                self.showChat = true
//                                self.otherUsername = name
//                            }
//                        },
//                        isActive: $showSearch,
//                        label: {
//                            Image(systemName: "magnifyingglass")
//                        })
//                }
//            }
//            .fullScreenCover(isPresented: $model.showingSignIn, content: {
//                SignInView()
//            })
//            .onAppear {
//                guard model.auth.currentUser != nil else {
//                    return
//                }
//                model.getConversations()
//            }
        }
    }
    func signOut() {
        model.signOut()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
            .environmentObject(AppStateModel())
    }
}
