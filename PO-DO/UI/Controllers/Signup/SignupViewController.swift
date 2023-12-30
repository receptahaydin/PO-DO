//
//  SignupViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 27.12.2023.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        NavCoordinator.shared.requestNavigation(to: LoginViewController(), with: .replace, setRoot: true)
    }
    
    @IBAction func buttonTapped(_ sender: LoaderButton) {
        let email = email.text!
        let password = password.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                return
            }
            
            sender.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                sender.isLoading = false
                NavCoordinator.shared.requestNavigation(to: HomeViewController(), with: .replace, setRoot: true)
            }
        }
    }
}
