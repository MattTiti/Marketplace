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
    @State var selectedIndex = 0
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
                        HomeView()
                    case 1:
                        SearchView() { _ in }
                    case 2:
                        
                        PostView()
                        
                    case 3:
                        ConversationListView()
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
    
    
    struct Navigation_Previews: PreviewProvider {
        static var previews: some View {
            Navigation()
                .environmentObject(AppStateModel())
        }
    }
}
