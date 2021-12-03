//
//  ImagePickerViewCoordinator.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 29/11/21.
//

import SwiftUI

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    init(image: Binding<Image?>, imageData: Binding<Data?>, isPresented: Binding<Bool>) {
        self._image = image
        self._imageData = imageData
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let width: CGFloat = 420.0
            let canvas = CGSize(width: width, height: CGFloat(ceil(width / uiImage.size.width * uiImage.size.height)))
            let imgResized = UIGraphicsImageRenderer(size: canvas, format: uiImage.imageRendererFormat).image { _ in
                uiImage.draw(in: CGRect(origin: .zero, size: canvas))
            }
            
            image = Image(uiImage: imgResized)
            imageData = imgResized.jpegData(compressionQuality: 0.5)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
