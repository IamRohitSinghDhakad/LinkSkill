//
//  PrivacyPolicyViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var webVw: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
}
