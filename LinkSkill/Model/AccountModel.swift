//
//  AccountModel.swift
//  LinkSkill
//
//  Created by Rohit SIngh Dhakad on 02/11/25.
//

import Foundation


class AccountHolderModel: NSObject {
    
    var str_account_number: String?
    var str_bank_name: String?
    var str_holder_name: String?
    var str_ifsc: String?
    var str_user_id: String?
    var totalReviews: String?
    var arrReviews: [MyReviewModel] = []
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["account_number"] as? Int {
            str_account_number = "\(value)"
        } else if let value = dictionary["account_number"] as? String {
            str_account_number = value
        } else {
            str_account_number = ""
        }
        
        if let value = dictionary["bank_name"] as? String {
            str_bank_name = value
        }
        
        if let value = dictionary["holder_name"] as? String {
            str_holder_name = value
        } else {
            str_holder_name = ""
        }
        
        if let value = dictionary["ifsc"] as? String {
            str_ifsc = value
        }
        
        if let value = dictionary["user_id"] as? Int {
            str_user_id = "\(value)"
        } else if let value = dictionary["user_id"] as? String {
            str_user_id = value
        } else {
            str_user_id = ""
        }
    
    }
}
