//
//  HomeView.swift
//  Message
//
//  Created by Matthew Titi on 7/8/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedIndex: Int
    @Binding var action: Int?
    @ObservedObject var viewModel = ItemListViewModel(model: AppStateModel())
    @State private var action1: String? = ""
    @Binding var isPresented: Bool
    @Binding var messageUsername: String
    
    var body: some View {
        NavigationView {
            
            ScrollView{
                VStack (){
                    
                    
                    HStack{
                        Text("      Essentials")
                        Spacer()
                        Text("See More       ")
                            .onTapGesture {
                                self.action = 1
                                self.isPresented = true
                                self.selectedIndex = 1
                            }
                            .foregroundColor(.blue)
                        
                    }
                    HStack {
                        ForEach(viewModel.essentials.prefix(4), id: \.self) { item in
                            NavigationLink(destination: ItemDetailView(item: item, selectedIndex: $selectedIndex, messageUsername: $messageUsername), tag: item.id, selection: $action1) {
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
                                        self.action1 = item.id
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    HStack{
                        Text("      Clothing")
                        Spacer()
                        Text("See More       ")
                            .onTapGesture {
                                self.action = 2
                                self.isPresented = true
                                self.selectedIndex = 1
                            }
                            .foregroundColor(.blue)
                    }
                    HStack {
                        ForEach(viewModel.clothing.prefix(4), id: \.self) { item in
                            NavigationLink(destination: ItemDetailView(item: item, selectedIndex: $selectedIndex, messageUsername: $messageUsername), tag: item.id, selection: $action1) {
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
                                            self.action1 = item.id
                                        }
                                }
                            }
                        }
                    }
                }
                VStack {
                    HStack{
                        Text("      Shoes")
                        Spacer()
                        Text("See More       ")
                            .onTapGesture {
                                self.action = 3
                                self.isPresented = true
                                self.selectedIndex = 1
                            }
                        .foregroundColor(.blue)                    }
                    HStack {
                        ForEach(viewModel.shoes.prefix(4), id: \.self) { item in
                            NavigationLink(destination: ItemDetailView(item: item, selectedIndex: $selectedIndex, messageUsername: $messageUsername), tag: item.id, selection: $action1) {
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
                                            self.action1 = item.id
                                        }
                                }
                            }
                        }
                    }
                    HStack{
                        Text("      Other")
                        Spacer()
                        Text("See More       ")
                            .onTapGesture {
                                self.action = 4
                                self.isPresented = true
                                self.selectedIndex = 1
                            }
                        .foregroundColor(.blue)                    }
                    HStack {
                        ForEach(viewModel.other.prefix(4), id: \.self) { item in
                            NavigationLink(destination: ItemDetailView(item: item, selectedIndex: $selectedIndex, messageUsername: $messageUsername), tag: item.id, selection: $action1) {
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
                                            self.action1 = item.id
                                        }
                                }
                            }
                            
                        }
                    }
                    HStack{
                        Text("      Saved")
                        Spacer()
                        Text("See More       ")
                            .onTapGesture {
                                self.action = 5
                                self.isPresented = true
                                self.selectedIndex = 1
                            }
                        .foregroundColor(.blue)                    }
                    HStack {
                        ForEach(viewModel.saved.prefix(4), id: \.self) { item in
                            NavigationLink(destination: SavedDetailView(item: item, selectedIndex: $selectedIndex, messageUsername: $messageUsername), tag: item.id, selection: $action1) {
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
                                            self.action1 = item.id
                                        }
                                }
                            }
                            
                        }
                    }
                    
                }
                .navigationTitle("Home").navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

