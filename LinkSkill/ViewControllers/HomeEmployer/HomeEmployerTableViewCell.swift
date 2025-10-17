//
//  HomeEmployerTableViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 15/10/25.
//

import UIKit

class HomeEmployerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblServicetype: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblEuros: UILabel!
    @IBOutlet weak var vwAwardedEmploye: UIView!
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var imgVwBriefcase: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblServicetype.applyStyle(AppFonts.subtitle)
        lblDescription.applyStyle(AppFonts.subtitle)
        lblEuros.applyStyle(AppFonts.subtitle)
        self.imgVwBriefcase.setImageColor(color: UIColor(named: "AppColor") ?? .systemYellow)
        
        self.vwAwardedEmploye.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
