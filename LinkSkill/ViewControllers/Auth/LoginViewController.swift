//
//  LoginViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

enum UserInfoType: String {
    case Employee
    case Employer
}

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnEmployee(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginFieldsViewController") as! LoginFieldsViewController
        vc.strType = UserInfoType.Employee.rawValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnOnEmployeer(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginFieldsViewController") as! LoginFieldsViewController
        vc.strType = UserInfoType.Employer.rawValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
