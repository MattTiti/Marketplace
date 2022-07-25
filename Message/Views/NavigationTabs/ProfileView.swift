//
//  ProfileView.swift
//  Message
//
//  Created by Matthew Titi on 7/8/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var model: AppStateModel
    @State var username: String = ""
    @State var otherUsername: String = ""
    @State var showChat = false
    @State var showSearch = false
    @State private var profileImage: Image = Image(systemName: "person.fill")
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            
            
            VStack(spacing: 20){
                HStack(spacing: 20){
                    ZStack{
                        profileImage
                            .profileImageStyle()
                            .onTapGesture {
                                showImagePicker = true
                            }
                            .onChange(of: inputImage) {_ in loadImage()}
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(image: $inputImage)
                            }
                        
                    }
                    
                        
                        Button("Edit Username"){
                            
                        }
                        
                    
                    
                }
                Divider()
                ScrollView{
                    Placeholder()
                    Placeholder()
                    Placeholder()
                    Placeholder()
                    Placeholder()
                    Placeholder()
                    Placeholder()
                }
                Spacer()
                
                if !otherUsername.isEmpty {
                    NavigationLink("",
                                   destination: ChatView(otherUsername: otherUsername),
                                   isActive: $showChat)
                }
                
            }
            
            .navigationTitle("Profile")
            
            
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) { Button("Sign Out") {
                    self.signOut()
                }
                }
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
            }
            
        }
        
    }
    func signOut() {
        model.signOut()
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        profileImage = Image(uiImage: inputImage)
    
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
