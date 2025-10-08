//
//  ProfileViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfRate: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfPin: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnOpenImageView(_ sender: Any) {
    }
    
    @IBAction func btnSave(_ sender: Any) {
    }
    
}
