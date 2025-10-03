//
//  LoginViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnEmployee(_ sender: Any) {
        self.pushVc(viewConterlerId: "LoginFieldsViewController")
    }
    
    @IBAction func btnOnEmployeer(_ sender: Any) {
        self.pushVc(viewConterlerId: "LoginFieldsViewController")
    }
}
