//
//  ImagePicker.swift
//  Message
//
//  Created by Matthew Titi on 7/23/22.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


//struct ImagePicker: UIViewControllerRepresentable{
//    @Binding var image: UIImage?
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context){
//
//    }
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//}
//class Coordinator: NSObject, PHPickerViewControllerDelegate{
//    let parent: ImagePicker
//
//    init(_ parent: ImagePicker){
//        self.parent = parent
//    }
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]){
//        picker.dismiss(animated: true)
//
//        guard let provider = results.first?.itemProvider else {return}
//
//        if provider.canLoadObject(ofClass: UIImage.self){
//            provider.loadObject(ofClass: UIImage.self) { image, _ in self.parent.image = image as? UIImage
//
//            }
//        }
//    }
//}

