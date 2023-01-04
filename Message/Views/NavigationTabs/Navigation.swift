//
//  Navigation.swift
//  Message
//
//  Created by Matthew Titi on 7/4/22.
//

import SwiftUI

struct TabItem {
    
}

struct Navigation: View {
    @Binding var selectedIndex: Int
    @Binding var action: Int?
    @Binding var isPresented: Bool
    @Binding var messageUsername: String
    @State var presented = false
    @EnvironmentObject var model: AppStateModel

    let icons = [
        "house",
        "magnifyingglass",
        "plus",
        "message",
        "person"
    ]
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ZStack {
                    

                    switch selectedIndex {
                    case 0:
                        HomeView(selectedIndex: $selectedIndex, action: $action, isPresented: $isPresented, messageUsername: $messageUsername)
                    case 1:
                        ItemListView(action: $action, selectedIndex: $selectedIndex, isPresented: $isPresented, messageUsername: $messageUsername)
                    case 2:
                        PostView(selectedIndex: $selectedIndex)
                        
                    case 3:
                        ConversationListView(messageUsername: $messageUsername)
                    default:
                        
                        ProfileView()
                        
                        
                    }
                }
                Divider()
                    .padding(.bottom, 20)
                HStack {
                    ForEach(0..<5, id: \.self) { number in
                        Spacer()
                        Button(action: {
                            self.selectedIndex = number
                            
                        }, label: {
                            if number == 2 {
                                Image(systemName: "plus")
                                    .font(.system(size: 25,
                                                  weight: .regular,
                                                  design: .default))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue)
                                    .cornerRadius(30)
                            }
                            else {
                                Image(systemName: icons[number])
                                    .font(.system(
                                        size: 25,
                                        weight: .regular,
                                        design: .default))
                                    .foregroundColor(selectedIndex == number ? Color(.label) : Color(UIColor.lightGray))
                            }
                        })
                        Spacer()
                        
                    }
                }
                .fullScreenCover(isPresented: $model.showingSignIn, content: {
                    SignInView()
                })
                .onAppear {
                    guard model.auth.currentUser != nil else {
                        return
                    }
                    model.getConversations()
                }
            }
            
        }
    }
    
}
    
