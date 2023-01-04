//
//  ListingView.swift
//  Message
//
//  Created by Matthew Titi on 7/24/22.
//

import SwiftUI

struct ListingView: View {
    private var slideImages = 2
    
    let slides = ["shirt2", "shirt3"]
    var body: some View {
        VStack(){
            TabView {
                ForEach(0..<slideImages) { num in Image("shirt3")
                        .resizable()
                        .frame(width: .infinity)
                        .scaledToFit()
                        .tag(num)
                }
            }.tabViewStyle(PageTabViewStyle())
            
//            Image("shirt2")
//                .resizable()
//                .frame(width: .infinity)
//                .aspectRatio(contentMode: .fit)
                
            ScrollView {
                VStack(alignment: .leading){
                Text("Nike Shirt")
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                Text("$20")
                    .font(.system(size: 20))
                Text("Overview")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding(.vertical, 1)
                
                Text("Category: Clothing")
                    .font(.system(size: 15))
                Text("Condition: Like New")
                    .font(.system(size: 15))
                Text("Size: Medium")
                    .font(.system(size: 15))
                
                
                    VStack(alignment: .leading){
                        Text("Description")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.vertical, 1)
                        Text("Worn a couple times, no stains are marks. Message with any questions. Open to offers. Prefer to pay in  cash.")
                            .font(.system(size: 16))
                            .padding(.vertical,2)
                        
                        
                        Text("Message Seller")
                            .aspectRatio(contentMode: .fit)
                            .font(.system(size: 15))
                            .frame(width: 130, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 120)
                            .padding(.vertical, 20)
                    }
               
            }
            }
            
            Spacer()
            
        }
        .padding(.horizontal, 10)
                
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
