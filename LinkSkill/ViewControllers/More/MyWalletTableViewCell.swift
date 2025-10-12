//
//  MyWalletTableViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit

class MyWalletTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDateTime: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblDateTime.applyStyle(AppFonts.subtitle_regular_12)
        self.lblDescription.applyStyle(AppFonts.price12)
        self.lblAmount.applyStyle(AppFonts.price12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
