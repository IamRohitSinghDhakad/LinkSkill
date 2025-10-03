//
//  SignUpViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    

    @IBAction func btnOnRegister(_ sender: Any) {
        
    }
}
