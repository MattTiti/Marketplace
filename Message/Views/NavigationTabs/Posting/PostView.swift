//
//  PostView.swift
//  Message
//
//  Created by Matthew Titi on 7/8/22.
//

import SwiftUI
import Combine


struct PostView: View {
    @Binding var selectedIndex: Int

    @State var description: String = ""
    @State var title: String = ""
    @State var category: String = "Essentials"
    @State var condition: String = "New"
    @State var size: String = "Other/None"
    @State private var value = 0
    @State var text: String = "Multiline \ntext \nis called \nTextEditor"



    
    @State private var profileImage: Image = Image(systemName: "plus")
    @State private var profileImage2: Image = Image(systemName: "plus")
    @State private var profileImage3: Image = Image(systemName: "plus")
    @State private var profileImage4: Image = Image(systemName: "plus")

    @State private var showImagePicker: Bool = false
    @State private var showImagePicker2: Bool = false
    @State private var showImagePicker3: Bool = false
    @State private var showImagePicker4: Bool = false



    @State private var inputImage: UIImage? = UIImage(contentsOfFile: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    @State private var inputImage2: UIImage? = UIImage(contentsOfFile: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    @State private var inputImage3: UIImage? = UIImage(contentsOfFile: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    @State private var inputImage4: UIImage? = UIImage(contentsOfFile: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")



      
    private let numberFormatter: NumberFormatter
        
        init(selectedIndex: Binding<Int>) {
          numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .currency
          numberFormatter.maximumFractionDigits = 0
            self._selectedIndex = selectedIndex

            // Use this if NavigationBarTitle is with large font
//            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: default, size: 20)!]
    }

    
    let categories = ["Essentials", "Clothing", "Shoes", "Other"]
    let conditions = ["New", "Like New", "Good", "Poor"]
    let sizes = ["Other/None", "Small", "Medium", "Large", "X-Large"]

    
    
    var body: some View {
        NavigationView{
        ScrollView{
            VStack{
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
                    ZStack{
                    profileImage2
                        .postImageStyle()
                        .onTapGesture {
                            showImagePicker2 = true
                        }
                        .onChange(of: inputImage2) {_ in loadImage2()}
                        .sheet(isPresented: $showImagePicker2) {
                            ImagePicker(image: $inputImage2)
                        }
                    }
                    ZStack{
                    profileImage3
                        .postImageStyle()
                        .onTapGesture {
                            showImagePicker3 = true
                        }
                        .onChange(of: inputImage3) {_ in loadImage3()}
                        .sheet(isPresented: $showImagePicker3) {
                            ImagePicker(image: $inputImage3)
                        }
                    }
                    ZStack{
                    profileImage4
                        .postImageStyle()
                        .onTapGesture {
                            showImagePicker4 = true
                        }
                        .onChange(of: inputImage4) {_ in loadImage4()}
                        .sheet(isPresented: $showImagePicker4) {
                            ImagePicker(image: $inputImage4)
                        }
                    }
                    
                    }
                    .padding()
                HStack{
                    Text("Title")
                        .foregroundColor(Color.gray)
                        .frame(width: 70, height: 10, alignment: .center
                        )
                    Spacer()
                }
                
                    TextField("", text: $title)
                        .frame(width: 380, height: 10, alignment: .leading)
                        .padding(11)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                HStack{
                    Text("Description")
                        .foregroundColor(Color.gray)
                        .frame(width: 120, height: 10, alignment: .center
                        )
                    Spacer()
                }
                
                TextEditor(text: $description)
                    .padding(11)
                    .frame(width: 400, height: 120, alignment: .topLeading)
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .stroke(Color.gray, lineWidth: 1)
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
                    .frame(width: 40, height: 10, alignment: .center)
                }
                .frame(width: 400, height: 60, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color.gray, lineWidth: 1)
                )
                HStack{
                    Text("Condition:")
                        .padding()
                    Picker("", selection: $condition) {
                        ForEach(conditions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 40, height: 10, alignment: .leading)
        
                }
                .frame(width: 400, height: 60, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                HStack{
                    Text("Size:")
                        .padding()
                    Picker("", selection: $size) {
                        ForEach(sizes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 40, height: 10, alignment: .center)
                    
                }
                .frame(width: 400, height: 60, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                HStack{
                    Text("Price:")
                        .padding()
                    TextField("$0.00", value: $value, formatter: numberFormatter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .frame(width: 60, height: 10, alignment: .center)

                }
                .frame(width: 400, height: 90, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color.gray, lineWidth: 1)
                )
                PostButton(title: $title, description: $description, category: $category, condition: $condition, size: $size, price: $value, image: $inputImage, image2: $inputImage2, image3: $inputImage3, image4: $inputImage4, selectedIndex: $selectedIndex)
            }
        }
        .navigationTitle("New Listing").navigationBarTitleDisplayMode(.inline)
            
            
        
        }
        
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        profileImage = Image(uiImage: inputImage).resizable()

        
    
    }
    func loadImage2(){
        guard let inputImage2 = inputImage2 else {return}
        profileImage2 = Image(uiImage: inputImage2).resizable()
    
    }
    func loadImage3(){
        guard let inputImage3 = inputImage3 else {return}
        profileImage3 = Image(uiImage: inputImage3).resizable()
    
    }
    func loadImage4(){
        guard let inputImage4 = inputImage4 else {return}
        profileImage4 = Image(uiImage: inputImage4).resizable()
    
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


//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
