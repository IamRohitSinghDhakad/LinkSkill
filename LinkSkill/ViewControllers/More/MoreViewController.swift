//
//  MoreViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    
    
    var arrData: [String] = ["My Wallet","Service History", "My Subscription", "My Reviews", "Edit Skills", "Language", "Contact Us", "Privacy Policy", "Terms & Conditions", "Logout", "Delete Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblVw.delegate = self
        self.tblVw.dataSource = self
        
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyWalletViewController")as! MyWalletViewController
            vc.isComingFrom = "Employee"
            self.navigationController?.pushViewController(vc, animated: true)
           // self.pushVc(viewConterlerId: "MyWalletViewController")
        } else if indexPath.row == 1 {
            self.pushVc(viewConterlerId: "ServiceHistoryViewController")
        } else if indexPath.row == 2 {
            self.pushVc(viewConterlerId: "MySubscriptionViewController")
        } else if indexPath.row == 3 {
            self.pushVc(viewConterlerId: "MyReviewsViewController")
        } else if indexPath.row == 4 {
            self.pushVc(viewConterlerId: "EditSkillsViewController")
        } else if indexPath.row == 5 {
            self.pushVc(viewConterlerId: "LanguageViewController")
        } else if indexPath.row == 6 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController")as! ContactUsViewController
            vc.isComingFrom = "Employee"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            self.pushVc(viewConterlerId: "PrivacyPolicyViewController")
        } else if indexPath.row == 8 {
            self.pushVc(viewConterlerId: "PrivacyPolicyViewController")
        } else if indexPath.row == 9 {
            // Logout
            objAlert.showAlertCallBack(alertLeftBtn: "Yes", alertRightBtn: "No", title: "Logout", message: "Are you sure you want to logout?", controller: self) {
                objAppShareData.signOut()
            }
        } else if indexPath.row == 10 {
            // Delete Account
           // self.call_WebService_DeleteAccount()
        }
        
    }
}
