//
//  HomeTableViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblServicetype: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblEuros: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbltitle.applyStyle(AppFonts.title)
        lblServicetype.applyStyle(AppFonts.subtitle)
        lblDescription.applyStyle(AppFonts.subtitle)
        lblEuros.applyStyle(AppFonts.price12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
