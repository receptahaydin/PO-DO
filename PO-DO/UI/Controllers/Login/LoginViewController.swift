//
//  LoginViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 28.12.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        NavCoordinator.shared.requestNavigation(to: SignupViewController(), with: .replace, setRoot: true)
    }
    
    @IBAction func signInTapped(_ sender: LoaderButton) {
        let email = email.text!
        let password = password.text!
        
        sender.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                let b1 = CRXDialogButton(title: "OK", style: .default)  { print("YES") }
                DialogView(title: "Error", message: error.localizedDescription, buttons: [b1]).show()
                sender.isLoading = false
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
