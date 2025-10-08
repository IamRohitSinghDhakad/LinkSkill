//
//  MoreTableViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 04/10/25.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.applyStyle(AppFonts.title_regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
