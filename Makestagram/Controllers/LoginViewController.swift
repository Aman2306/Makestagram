//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Aman Meena on 03/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
//import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK:- IBActions
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // 1
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        
        // 2
        authUI.delegate = self
        let providers: [FUIAuthProvider] = [FUIEmailAuth(), FUIGoogleAuth()]
        
        authUI.providers = providers
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        // 1
        guard let user = authDataResult?.user
            else { return }
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                User.setCurrent(user)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            } else {
                
                self.performSegue(withIdentifier: K.Segue.toCreateUsername, sender: self)
            }
        }
    }
}


/* Phone Verification
 PhoneAuthProvider.provider().verifyPhoneNumber("+91 9468583662", uiDelegate: nil) { (verificationID, error) in
     if error != nil {
         assertionFailure("Phone Verification Failded: \(String(describing: error?.localizedDescription))")
         return
     }
 }
 
 */
