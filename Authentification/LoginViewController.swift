//
//  LoginViewController.swift
//  Authentification
//
//  Created by Mohamed Ali BELHADJ on 2022-01-17.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // validate text fields
        
        // clean
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        //sign in
        Auth.auth().signIn(withEmail: email, password: password) { (result, error ) in
            
            if error != nil {
                
                self.errorLabel.text = "error occured"
                self.errorLabel.alpha = 1
                
            }
            else {
                let homeViewController =  self.storyboard?.instantiateViewController(identifier:Constants.Storyboard.homeViewController) as? HomeViewController
                 
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
