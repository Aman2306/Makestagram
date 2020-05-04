//
//  MGPhotoHelper.swift
//  Makestagram
//
//  Created by Aman Meena on 04/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit

class MGPhotoHelper: NSObject {
    
    // MARK:- Properties
    
    var completionHandler: ((UIImage) -> Void)?
    
    // MARK:- Helper Methods
    
    func presentActionSheet(from viewController: UIViewController) {
        // 1
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)

        // 2
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // 3
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { action in
                self.presentImagePickerController(with: .camera, from: viewController)
            })

            // 4
            alertController.addAction(capturePhotoAction)
        }

        // 5
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) { // this checks whether camera is available or not i.e., simulator or actual device
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: { action in
                // do nothing yet...
                self.presentImagePickerController(with: .photoLibrary, from: viewController)
            })

            alertController.addAction(uploadAction)
        }

        // 6
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // 7
        viewController.present(alertController, animated: true)
    }
    
    func presentImagePickerController(with sourceType: UIImagePickerController.SourceType, from viewController: UIViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType

        imagePickerController.delegate = self
        
        viewController.present(imagePickerController, animated: true)
    }
}

extension MGPhotoHelper:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            completionHandler?(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
