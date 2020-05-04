//
//  UserService.swift
//  Makestagram
//
//  Created by Aman Meena on 04/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

/*
 A service layer helps you decouple your view controllers from your networking logic. We want to remove the networking code, such as reading and writing to our database, so that we can reuse the same code and access our networking logic from other view controllers.
 */

struct UserService {
    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]

        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid) // Database Reference
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }

            completion(user)
        })
    }
}
