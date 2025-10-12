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
    @IBOutlet weak var vwAlreadyBid: UIView!
    @IBOutlet weak var lblAlreadyBid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbltitle.applyStyle(AppFonts.title)
        lblServicetype.applyStyle(AppFonts.subtitle)
        lblDescription.applyStyle(AppFonts.subtitle)
        lblEuros.applyStyle(AppFonts.price12)
        self.imgVw.setImageColor(color: UIColor(named: "AppColor") ?? .systemYellow)
        self.vwAlreadyBid.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



extension UIImage {
    /// Returns a new image tinted with the given color.
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return nil }

        // Flip context to match iOS coordinate system
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        let rect = CGRect(origin: .zero, size: size)

        // Draw the original image
        context.setBlendMode(.normal)
        context.draw(cgImage, in: rect)

        // Apply color
        context.setBlendMode(.sourceIn)
        color.setFill()
        context.fill(rect)

        let tintedImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return tintedImg
    }
}
