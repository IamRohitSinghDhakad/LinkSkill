//
//  MySubscriptionCollectionViewCell.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 12/10/25.
//

import UIKit

class MySubscriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vwOuter: UIView!
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblPlanName.applyStyle(AppFonts.price12)
        self.lblDays.applyStyle(AppFonts.price12)
        self.lblPrice.applyStyle(AppFonts.price18)
    }
    
    func configureCell(with plan: MySubscriptionModel, isSelected: Bool) {
           lblPlanName.text = plan.name
           lblDays.text = "\(plan.validity ?? "") Days"
           lblPrice.text = "$\(plan.price ?? "")"
           
           // Highlighting logic
           if isSelected {
               lblPlanName.textColor = UIColor(named: "AppColor")
               lblDays.textColor = UIColor(named: "AppColor")
               lblPrice.textColor = UIColor(named: "AppColor")
           } else {
               lblPlanName.textColor = .black
               lblDays.textColor = .black
               lblPrice.textColor = .black
           }
       }
}
