//
//  LoginFieldsViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class LoginFieldsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
   
    @IBAction func btnOnforgetPassword(_ sender: Any) {
        pushVc(viewConterlerId: "ForgetPasswordViewController")
    }
    @IBAction func btnOnLogin(_ sender: Any) {
        pushVc(viewConterlerId: "ForgetPasswordViewController")
    }
    @IBAction func btnOnSignUp(_ sender: Any) {
        pushVc(viewConterlerId: "SignUpViewController")
    }
}
