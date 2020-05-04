//
//  StorageReference+Post.swift
//  Makestagram
//
//  Created by Aman Meena on 05/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()

    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())

        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
}
