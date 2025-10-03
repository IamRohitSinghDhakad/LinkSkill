//
//  ForgetPasswordViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
    @IBAction func btnOnSubmit(_ sender: Any) {
        
    }
}
