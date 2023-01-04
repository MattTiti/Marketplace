//
//  ResultsView.swift
//  Message
//
//  Created by Matthew Titi on 7/8/22.
//

import SwiftUI


struct ItemListView: View {
    @ObservedObject var viewModel = ItemListViewModel(model: AppStateModel())
    @State private var action1: String? = ""
    @Binding var action: Int?
    @Binding var selectedIndex: Int
    @Binding var isPresented: Bool
    @Binding var messageUsername: String

    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    ForEach(viewModel.items.chunked(into: 3), id: \.self) { items in
                        HStack {
                            ForEach(items, id: \.self) { item in
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

                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                .onTapGesture {
                                                    // Perform some tasks if needed before opening Destination view
                                                    self.action1 = item.id
                                                }
                                            Text("$\(item.price)")
                                                .foregroundColor(.black)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Posts").navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isPresented, content: {
                            switch action {
                            case 1:
                                EssentialsItemListView(isPresented: $isPresented, selectedIndex: $selectedIndex, messageUsername: $messageUsername)
                            case 2:
                                ClothingItemListView(isPresented: $isPresented, selectedIndex: $selectedIndex, messageUsername: $messageUsername)
                            case 3:
                                ShoesItemListView(isPresented: $isPresented, selectedIndex: $selectedIndex, messageUsername: $messageUsername)
                            case 4:
                                OtherItemListView(isPresented: $isPresented, selectedIndex: $selectedIndex, messageUsername: $messageUsername)
                            case 5:
                                SavedItemsView(isPresented: $isPresented, selectedIndex: $selectedIndex, messageUsername: $messageUsername)
                            default:
                                EmptyView()
                            }
                        })
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}
