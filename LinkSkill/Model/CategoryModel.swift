//
//  CategoryModel.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 09/10/25.
//

import UIKit

class CategoryModel: NSObject {
    
    var id: String?
    var name: String?
    var image: String?
    var status: Int?
    var isSelected: Int?
    var isSelectedCell: Bool = false
    var entryDate: String?
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        // MARK: - ID
        if let value = dictionary["id"] as? Int {
            id = "\(value)"
        } else if let value = dictionary["id"] as? String {
            id = value
        } else {
            id = ""
        }
        
        // MARK: - Name
        if let value = dictionary["name"] as? String {
            name = value
        } else {
            name = ""
        }
        
        // MARK: - Image
        if let value = dictionary["image"] as? String {
            image = value
        } else {
            image = ""
        }
        
        // MARK: - Status
        if let value = dictionary["status"] as? Int {
            status = value
        } else if let value = dictionary["status"] as? String, let intVal = Int(value) {
            status = intVal
        } else {
            status = 0
        }
        
        // MARK: - isSelected
        if let value = dictionary["is_selected"] as? Int {
            isSelected = value
        } else if let value = dictionary["is_selected"] as? String, let intVal = Int(value) {
            isSelected = intVal
        } else {
            isSelected = 0
        }
        
        // MARK: - Entry Date
        if let value = dictionary["entrydt"] as? String {
            entryDate = value
        } else {
            entryDate = ""
        }
    }
}

    
  
