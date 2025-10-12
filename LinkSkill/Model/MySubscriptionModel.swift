//
//  MySubscriptionModel.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 12/10/25.
//

import UIKit

class MySubscriptionModel: NSObject {
    
    var id: String?
    var name: String?
    var price: String?
    var validity: String?
    var planStatus: String?
    var entryDate: String?
    var status: String?
    var isSelected: Bool?
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["id"] as? Int {
            id = "\(value)"
        } else if let value = dictionary["id"] as? String {
            id = value
        } else {
            id = ""
        }
        
        if let value = dictionary["name"] as? String {
            name = value
        } else {
            name = ""
        }
        
        if let value = dictionary["price"] as? Double {
            price = "\(value)"
        } else if let value = dictionary["price"] as? Int {
            price = "\(value)"
        } else if let value = dictionary["price"] as? String {
            price = value
        } else {
            price = ""
        }
        
        if let value = dictionary["validity"] as? Int {
            validity = "\(value)"
        } else if let value = dictionary["validity"] as? String {
            validity = value
        } else {
            validity = ""
        }
        
        if let value = dictionary["plan_status"] as? String {
            planStatus = value
        } else {
            planStatus = ""
        }
        
        if let value = dictionary["entrydt"] as? String {
            entryDate = value
        } else {
            entryDate = ""
        }
        
        if let value = dictionary["status"] as? Int {
            status = "\(value)"
        } else if let value = dictionary["status"] as? String {
            status = value
        } else {
            status = ""
        }
        
        if let value = dictionary["is_selected"] as? Bool {
            isSelected = value
        } else if let value = dictionary["is_selected"] as? Int {
            isSelected = (value == 1)
        } else if let value = dictionary["is_selected"] as? String {
            isSelected = (value == "1" || value.lowercased() == "true")
        } else {
            isSelected = false
        }
    }
}
