//
//  SignUpViewController.swift
//  Authentification
//
//  Created by Mohamed Ali BELHADJ on 2022-01-17.
//

import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func isPasswordValid(_ password: String)-> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")

        return passwordTest.evaluate(with: password)
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
        func transitionToHome(){
           let homeViewController =  storyboard?.instantiateViewController(identifier:Constants.Storyboard.homeViewController) as? HomeViewController
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
        }
    
    func validateFields() ->String? {
        // check if fields empty
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        
        // check if password is okay
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanPassword) == false{
            return "please check password"
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        // validate the fields
         let error = validateFields()
        if error != nil {
           showError(error!)
        }
        else {
            let firstname = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // create user
            Auth.auth().createUser(withEmail: email , password: password) {(result, err) in
            if  err != nil  {
                self.errorLabel.text = "error creating user"
                self.errorLabel.alpha = 1

            }
            else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstname" : firstname , "lastname": lastname, "uid": result!.user.uid]) { (error) in
                    
                    if error != nil {
                        self.errorLabel.text = "error saving data"
                        self.errorLabel.alpha = 1

                    }
                }
            }
        // go to homescreen
                self.transitionToHome()
        }
    }
    }
}
