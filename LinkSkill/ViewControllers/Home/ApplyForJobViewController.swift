//
//  ApplyForJobViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 04/10/25.
//

import UIKit

class ApplyForJobViewController: UIViewController {

    @IBOutlet weak var lblHeadertitle: UILabel!
    
    var objJobDetails: JobsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    

}
