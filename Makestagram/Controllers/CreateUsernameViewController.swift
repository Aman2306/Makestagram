//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Aman Meena on 03/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateUsernameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    // MARK:- IBActions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            User.setCurrent(user)
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
