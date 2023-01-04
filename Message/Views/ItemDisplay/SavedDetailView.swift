//
//  SavedDetailView.swift
//  Message
//
//  Created by Matthew Titi on 1/2/23.
//

import SwiftUI

struct SavedDetailView: View {
    let slides = ["shirt2", "shirt3"]
    @State private var isActive: Bool = false
    @Binding var selectedIndex: Int
    @Binding var messageUsername: String
    @EnvironmentObject var model: AppStateModel
    @State var showAlert = false

    var item: Item
    var slideImages: [URL]
    
    init(item: Item, selectedIndex: Binding<Int>, messageUsername: Binding<String>) {
        self.item = item
        self.slideImages = [item.picture, item.picture2, item.picture3, item.picture4]
        self._selectedIndex = selectedIndex
        self._messageUsername = messageUsername
    }
    
    var body: some View {
            VStack{
                TabView {
                    ForEach(0..<slideImages.count) { num in
                        
                        AsyncImage(url: slideImages[num],
                                   content: { image in
                            image.resizable(resizingMode: .stretch)
                                
                        },
                                   placeholder: {
                            ProgressView()
                        }
                        )
                            .scaledToFit()
                            .tag(num)                        //                    Image(uiImage: item.picture)
                        //                        .resizable()
                        //                        .frame(width: .infinity)
                        //                        .scaledToFit()
                        //                        .tag(num)
                    }
                }.tabViewStyle(PageTabViewStyle())
                
                //            Image("shirt2")
                //                .resizable()
                //                .frame(width: .infinity)
                //                .aspectRatio(contentMode: .fit)
                ScrollView {
                    VStack(alignment: .leading){
                        Text(item.title)
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        Text("$\(item.price)")
                            .font(.system(size: 20))
                        Text("Overview")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.vertical, 1)
                        
                        Text("Category: \(item.category)")
                            .font(.system(size: 15))
                        Text("Condition: \(item.condition)")
                            .font(.system(size: 15))
                        Text("Size: \(item.size)")
                            .font(.system(size: 15))
                        
                        
                        VStack(alignment: .leading){
                            Text("Description")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .padding(.vertical, 1)
                            Text("\(item.description)")
                                .font(.system(size: 16))
                                .padding(.vertical,2)
                            
                        }
                        HStack {
                            Button(action: {
                                selectedIndex = 3
                                messageUsername = item.username
                            }, label: {
                                Text("Message Seller")
                                    .aspectRatio(contentMode: .fit)
                                    .font(.system(size: 15))
                                    .frame(width: 160, height: 50)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 20)
                            })
                                Button(action: {
                                    self.showAlert =  true
                                    selectedIndex = 0
                                    model.unsavePost(id: item.id)
                                }, label: {
                                    Text("Unsave Post")
                                        .aspectRatio(contentMode: .fit)
                                        .font(.system(size: 15))
                                        .frame(width: 160, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 20)
                                })
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("Success"), message: Text("Post Unsaved Succesfully"), dismissButton: .default(Text("OK")) {
                                        self.showAlert = false
                                    })
                                }

                    }
                        
                    }
                    .padding(.horizontal, 10)

                }

            }
        
    }
}

//struct SavedDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedDetailView()
//    }
//}
