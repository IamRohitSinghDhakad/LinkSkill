//
//  MyReviewTableViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 12/10/25.
//

import UIKit

class MyReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var vwRatings: FloatRatingView!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblUserName.applyStyle(AppFonts.price18)
        self.lblDate.applyStyle(AppFonts.subtitle_regular_12)
        self.lblDesc.applyStyle(AppFonts.subtitle_regular_12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
