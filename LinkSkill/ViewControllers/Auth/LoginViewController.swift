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
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnEmployee: UIButton!
    @IBOutlet weak var btnEmployeer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLocalization()
    }
    
    func setLocalization(){
        self.lblWelcome.text = L10n.welcomeToLinkskill + L10n.appName
        self.lblDesc.text = L10n.welcomeText
        self.btnEmployee.setLocalizedTitle(L10n.employee)
        self.btnEmployeer.setLocalizedTitle(L10n.employer)
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
