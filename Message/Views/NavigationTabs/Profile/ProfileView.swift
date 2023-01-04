//
//  ProfileView.swift
//  Message
//
//  Created by Matthew Titi on 7/8/22.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ItemListViewModel(model: AppStateModel())
    @State private var action1: String? = ""
    @EnvironmentObject var model: AppStateModel
    @State var username: String = ""
    @State var otherUsername: String = ""
    @State var showChat = false
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var isActive: Bool = true
    
    var body: some View {
        NavigationView {
            VStack(){

                List{
                    ForEach(viewModel.items.filter { $0.username == model.currentUsername }, id: \.self) { item in
                        NavigationLink(destination: EditItemView(title: item.title, category: item.category, condition: item.condition, description: item.description, size: item.size, price: item.price, picture: item.picture, picture2: item.picture2, picture3: item.picture3, picture4: item.picture4, id: item.id, isActive: $isActive), tag: item.id, selection: $action1) {
                            HStack {
                                
                                VStack(alignment: .leading) {
                                    
                                    AsyncImage(url: item.picture,
                                               content: { image in
                                        image.resizable(resizingMode: .stretch)
                                    },
                                               placeholder: {
                                        ProgressView()
                                    }
                                    )
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            // Perform some tasks if needed before opening Destination view
                                            self.action1 = item.id
                                        }
                                }
                                VStack(alignment: .leading){
                                    Text("\(item.title)").font(.headline)
                                    Text("Category: \(item.category)").font(.subheadline)
                                    Text("Condition: \(item.condition)").font(.subheadline)
                                    Text("Price: $\(item.price)").font(.subheadline)
                                    
                                }
                            }
                            
                        }
                    }
                }
                Spacer()
                
                //                if !otherUsername.isEmpty {
                //                    NavigationLink("",
                //                                   destination: ChatView(otherUsername: otherUsername),
                //                                   isActive: $showChat)
                //                }
                
            }
            
            .navigationTitle("Your Listings")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) { Button("Sign Out") {
                    self.signOut()
                }
                }
                
            }
            
        }
        
    }
    func signOut() {
        model.signOut()
    }

}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
            ProfileView()
        }
    }
}
