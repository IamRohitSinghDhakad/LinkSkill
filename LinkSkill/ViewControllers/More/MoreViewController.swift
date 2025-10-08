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
}
