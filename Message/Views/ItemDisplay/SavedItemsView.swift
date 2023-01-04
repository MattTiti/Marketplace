//
//  SavedItemsView.swift
//  Message
//
//  Created by Matthew Titi on 1/2/23.
//

import SwiftUI

struct SavedItemsView: View {
    @ObservedObject var viewModel = ItemListViewModel(model: AppStateModel())
    @State private var action: String? = ""
    @Binding var isPresented: Bool
    @Binding var selectedIndex: Int
    @Binding var messageUsername: String

    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    
                    ForEach(viewModel.saved.chunked(into: 3), id: \.self) { items in
                        HStack {
                            ForEach(items, id: \.self) { item in
                                NavigationLink(destination: ItemDetailView(item: item, selectedIndex: $selectedIndex, messageUsername: $messageUsername), tag: item.id, selection: $action) {
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
                                                    self.action = item.id
                                                }
                                            Text("$\(item.price)")
                                                .foregroundColor(.black)
                                        }
                                    }
                                
                                
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Saved").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) { Button("Exit") {
                    isPresented = false
                    selectedIndex = 1
                }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}

//struct SavedItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedItemsView()
//    }
//}
