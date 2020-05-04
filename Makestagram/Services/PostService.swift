//
//  PostService.swift
//  Makestagram
//
//  Created by Aman Meena on 04/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

struct PostService {
    
    static func create(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }

            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
        }
    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        // create new post in database
        
        // 1
        let currentUser = User.current
        // 2
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        // 3
        let dict = post.dictValue

        // 4
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        //5
        postRef.updateChildValues(dict)
    }
}
