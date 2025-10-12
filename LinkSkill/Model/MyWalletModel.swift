//
//  MyWalletModel.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit

class MyWalletModel: NSObject {
    
    var transactionId: String?
    var amount: String?
    var amountText: String?
    var currency: String?
    var descriptionText: String?
    var entryDate: String?
    var jobType: String?
    var payerName: String?
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        // MARK: - Transaction ID
        if let value = dictionary["transaction_id"] as? Int {
            transactionId = "\(value)"
        } else if let value = dictionary["transaction_id"] as? String {
            transactionId = value
        } else {
            transactionId = ""
        }
        
        // MARK: - Amount
        if let value = dictionary["amount"] as? Int {
            amount = "\(value)"
        } else if let value = dictionary["amount"] as? Double {
            amount = "\(value)"
        } else if let value = dictionary["amount"] as? String {
            amount = value
        } else {
            amount = ""
        }
        
        // MARK: - Amount Text
        if let value = dictionary["amount_text"] as? String {
            amountText = value
        } else {
            amountText = ""
        }
        
        // MARK: - Currency
        if let value = dictionary["currency"] as? String {
            currency = value
        } else {
            currency = ""
        }
        
        // MARK: - Description
        if let value = dictionary["description"] as? String {
            descriptionText = value
        } else {
            descriptionText = ""
        }
        
        // MARK: - Entry Date
        if let value = dictionary["entrydt"] as? String {
            entryDate = value
        } else {
            entryDate = ""
        }
        
        // MARK: - Job Type
        if let value = dictionary["job_type"] as? String, value != "<null>" {
            jobType = value
        } else {
            jobType = ""
        }
        
        // MARK: - Payer Name
        if let value = dictionary["payer_name"] as? String, value != "<null>" {
            payerName = value
        } else {
            payerName = ""
        }
    }
}
