//
//  HomeView.swift
//  Message
//
//  Created by Matthew Titi on 7/8/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                VStack (){
                    HStack{
                        Text("      Essentials")
                        Spacer()
                        Button("See More           "){
                            
                        }
                    }
                    Placeholder()
                    HStack{
                        Text("      Clothing")
                        Spacer()
                        Button("See More           "){
                            
                        }
                    }
                    Placeholder()
                    HStack{
                        Text("      Shoes")
                        Spacer()
                        Button("See More           "){
                            
                        }
                    }
                    Placeholder()
                    HStack{
                        Text("      Other")
                        Spacer()
                        Button("See More           "){
                            
                        }
                    }
                    Placeholder()
               
                }
                .navigationTitle("Home")
            }
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
