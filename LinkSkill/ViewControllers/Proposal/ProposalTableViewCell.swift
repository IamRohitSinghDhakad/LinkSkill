//
//  ProposalTableViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 16/10/25.
//

import UIKit

class ProposalTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnOnChat: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblInDays: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
