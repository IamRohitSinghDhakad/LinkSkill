//
//  ChatDetailTableViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 14/10/25.
//

import UIKit

class ChatDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var vwMyMsg: UIView!
    @IBOutlet weak var vwOpponentMessage: UIView!
    @IBOutlet weak var vwMyImage: UIView!
    @IBOutlet weak var vwOpponentImage: UIView!
    @IBOutlet weak var vwMyDocument: UIView!
    @IBOutlet weak var vwOpponentDocumnet: UIView!
    @IBOutlet weak var lblMyMsgTxt: UILabel!
    @IBOutlet weak var lblMyMsgTime: UILabel!
    @IBOutlet weak var lblOpponentTxtMsg: UILabel!
    @IBOutlet weak var lblOpponentTimeTxt: UILabel!
    @IBOutlet weak var imgVwMy: UIImageView!
    @IBOutlet weak var lblTimeImageMySide: UILabel!
    @IBOutlet weak var imgVwopponent: UIImageView!
    @IBOutlet weak var lblImgTimeOpponent: UILabel!
    @IBOutlet weak var btnMyDoc: UIButton!
    @IBOutlet weak var btnOpponentDoc: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
