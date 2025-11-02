//
//  MoreEmployerViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 15/10/25.
//

import UIKit

class MoreEmployerViewController: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    
    var arrData: [String] = ["My Wallet","Language", "Contact Us", "Privacy Policy", "Terms & Conditions", "Logout", "Delete Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblVw.delegate = self
        self.tblVw.dataSource = self
        
    }
}

extension MoreEmployerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell") as! MoreTableViewCell
        
        cell.lblTitle.text = self.arrData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.pushVc(viewConterlerId: "MyWalletViewController")
        } else if indexPath.row == 1 {
            self.pushVc(viewConterlerId: "LanguageViewController")
        } else if indexPath.row == 2 {
            self.pushVc(viewConterlerId: "ContactUsViewController")
        } else if indexPath.row == 3 {
            let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")as! PrivacyPolicyViewController
            vc.isComingfrom = "Privacy Policy"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = self.mainStoryboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")as! PrivacyPolicyViewController
            vc.isComingfrom = "Terms"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            // Logout
            objAlert.showAlertCallBack(alertLeftBtn: "Yes", alertRightBtn: "No", title: "Logout", message: "Are you sure you want to logout?", controller: self) {
                objAppShareData.signOut()
            }
        } else if indexPath.row == 6 {
            // Delete Account
           // self.call_WebService_DeleteAccount()
        }
        
    }
}
