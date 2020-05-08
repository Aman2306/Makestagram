//
//  LikeService.swift
//  Makestagram
//
//  Created by Aman Meena on 08/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct LikeService {
    
    
    // To like a post
    static func create(for post: Post, success: @escaping (Bool) -> Void) {
        // 1 Each post that we like must have a key. We check that the post has a key and return false if there is not.
        guard let key = post.key else {
            return success(false)
        }
        
        // 2 reference to the current user's UID
        let currentUID = User.current.uid
        
        // 3 code to like a post
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
        likesRef.setValue(true) { (error, _) in // setValue is 'true'
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            
            return success(true)
        }
        
        // Transaction Block to increment the likes count
        let likeCountRef = Database.database().reference().child("posts").child(post.poster.uid).child(key).child("like_count")
        likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
            let currentCount = mutableData.value as? Int ?? 0
            
            mutableData.value = currentCount + 1
            
            return TransactionResult.success(withValue: mutableData)
        }, andCompletionBlock: { (error, _, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            } else {
                success(true)
            }
        })
        
    }
    
    // To unlike a post
    static func delete(for post: Post, success: @escaping (Bool) -> Void) {
        guard let key = post.key else {
            return success(false)
        }
        
        let currentUID = User.current.uid
        
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
        likesRef.setValue(nil) { (error, _) in // setValue is 'nil'
            
            /* You could have also used the 'removeValue(completionBlock:)' method of DatabaseReference to delete the like object in our database. */
            
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            
            return success(true)
        }
        
        
        let likeCountRef = Database.database().reference().child("posts").child(post.poster.uid).child(key).child("like_count")
        likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
            let currentCount = mutableData.value as? Int ?? 0
            
            mutableData.value = currentCount - 1
            
            return TransactionResult.success(withValue: mutableData)
        }, andCompletionBlock: { (error, _, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            } else {
                success(true)
            }
        })
    }
    
    static func isPostLiked(_ post: Post, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        guard let postKey = post.key else {
            assertionFailure("Error: post must have key.")
            return completion(false)
        }

        let likesRef = Database.database().reference().child("postLikes").child(postKey)
        likesRef.queryEqual(toValue: nil, childKey: User.current.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    static func setIsLiked(_ isLiked: Bool, for post: Post, success: @escaping (Bool) -> Void) {
        if isLiked {
            create(for: post, success: success)
        } else {
            delete(for: post, success: success)
        }
    }
    
}
