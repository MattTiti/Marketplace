//
//  PostView.swift
//  Message
//
//  Created by Matthew Titi on 7/8/22.
//

import SwiftUI
import Combine


struct PostView: View {
    @State var description: String = ""
    @State var title: String = ""
    @State var category: String = ""
    @State var condition: String = ""
    @State private var value = 0
    @State private var profileImage: Image = Image(systemName: "plus")
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?

      
    private let numberFormatter: NumberFormatter
        
        init() {
          numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .currency
          numberFormatter.maximumFractionDigits = 0
        }

    
    let categories = ["Essentials", "Clothing", "Shoes", "Other"]
    let conditions = ["New", "Like New", "Good", "Poor"]
    
    
    var body: some View {
        NavigationView{
        ScrollView{
            VStack(alignment: .center){
                HStack{
                    ZStack{
                    profileImage
                        .postImageStyle()
                        .onTapGesture {
                            showImagePicker = true
                        }
                        .onChange(of: inputImage) {_ in loadImage()}
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $inputImage)
                        }
                    }
                    }
                    .padding()
               
                TextField("Title", text: $title)
                    .frame(width: 340, height: 5, alignment: .leading)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .stroke(Color.black, lineWidth: 3)
                    )
                
                TextField("Description", text: $description)
                    .padding(8)
                    .frame(width: 360, height: 80, alignment: .topLeading)
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .stroke(Color.black, lineWidth: 3)
                    )
                HStack{
                    
                    
                    Text("Category:")
                        .padding()
                    Picker("", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 100, height: 60, alignment: .center)
                    
                }
                HStack{
                    Text("Condition:")
                        .padding()
                    Picker("", selection: $condition) {
                        ForEach(conditions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 100, height: 60, alignment: .center)
                    
                }
                HStack{
                    Text("Price:")
                        .padding()
                    TextField("$0.00", value: $value, formatter: numberFormatter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .frame(width: 60, height: 60, alignment: .center)

                }
                PostButton(title: $title, description: $description, category: $category, condition: $condition, price: $value, image: $inputImage)
                Spacer()
                
            }
        }
        .navigationTitle("New Listing")
        
        }
        
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        profileImage = Image(uiImage: inputImage).resizable()
    
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(60)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 3)
            )
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
