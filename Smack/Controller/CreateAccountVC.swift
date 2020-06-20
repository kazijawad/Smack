//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Kazi Jawad on 6/14/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func chooseBackgroundColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let password = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password) { (success) in
                    if success {
                        print("Logged In User!", AuthService.instance.authToken)
                    }
                }
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
