//
//  ImagePickerView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 24/01/2024.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var isPresented: Bool
    @Binding var image: Image?
    @Binding var imageData: Data?
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, imageData:$imageData, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType){
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = sourceType
        }
        
        pickerController.delegate = context.coordinator
        
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

class ImagePickerViewCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @Binding var isPresented: Bool
    @Binding var image: Image?
    @Binding var imageData: Data?
    
    init(image: Binding<Image?>, imageData:Binding<Data?>, isPresented: Binding<Bool>){
        self._image = image
        self._imageData = imageData
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.image = Image(uiImage: image)
            self.imageData = image.jpegData(compressionQuality: 0.5)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}
