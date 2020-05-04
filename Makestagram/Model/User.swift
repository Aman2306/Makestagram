//
//  User.swift
//  Makestagram
//
//  Created by Aman Meena on 03/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: Codable {

    // MARK: - Properties

    let uid: String
    let username: String
    
    // MARK:- Singleton
    // 1
    private static var _current: User?
    
    
    // 2
    static var current: User {
        // 3
        guard let currentUser = _current else {
            fatalError("User doesn't exist")
        }
        
        // 4
        return currentUser
    }

    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: K.UserDefaults.currentUser)
            }
        }
    }
    
    
    
    // MARK: - Init

    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }

    /* Failable Initializer - Failable initializers allow the initialization of an object to fail. If an initializer fails, it'll return nil instead. This is useful for requiring the initialization to have key information. In our case, if a user doesn't have a UID or a username, we'll fail the initialization and return nil.
     */
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }

        self.uid = snapshot.key
        self.username = username
    }
    
    // MARK:- Methods
    static func setCurrent(_ user: User) {
        _current = user
    }
}
