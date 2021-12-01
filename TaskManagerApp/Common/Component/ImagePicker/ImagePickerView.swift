//
//  ImagePickerView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 29/11/21.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image,
                                          imageData: $imageData,
                                          isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
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
