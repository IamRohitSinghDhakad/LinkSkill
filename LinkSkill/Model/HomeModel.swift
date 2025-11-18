//
//  HomeModel.swift
//  Culturally Yours App
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 26/04/25.
//

import UIKit

class JobsModel: NSObject {
    
    var id: String?
    var categoryID: String?
    var categoryName: String?
    var details: String?
    var currency: String?
    var price: Double?
    var status: String?
    var type: String?
    var isActive: Int?
    var isBided: Int?
    var paymentID: String?
    var userID: String?
    var userName: String?
    var userImage: String?
    var employeeID: String?
    var employeeName: String?
    var employeeImage: String?
    var entryDate: String?
    var strRating :Double?
    var strReview: String?
    var isSelected: Bool = false
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        // MARK: - ID
        if let value = dictionary["id"] as? Int {
            id = "\(value)"
        } else if let value = dictionary["id"] as? String {
            id = value
        }
        
        // MARK: - Category ID
        if let value = dictionary["category_id"] as? Int {
            categoryID = "\(value)"
        } else if let value = dictionary["category_id"] as? String {
            categoryID = value
        }
        
        // MARK: - Category Name
        if let value = dictionary["category_name"] as? String {
            categoryName = value
        } else {
            categoryName = ""
        }
        
        // MARK: - Details
        if let value = dictionary["details"] as? String {
            details = value
        } else {
            details = ""
        }
        
        // MARK: - Currency
        if let value = dictionary["currency"] as? String {
            currency = value
        } else {
            currency = ""
        }
        
        // MARK: - Price
        if let value = dictionary["price"] as? Double {
            price = value
        } else if let value = dictionary["price"] as? Int {
            price = Double(value)
        } else if let value = dictionary["price"] as? String, let doubleVal = Double(value) {
            price = doubleVal
        } else {
            price = 0.0
        }
        
        if let value = dictionary["rating"] as? Double {
            strRating = value
        } else if let value = dictionary["rating"] as? Int {
            strRating = Double(value)
        } else if let value = dictionary["rating"] as? String, let doubleVal = Double(value) {
            strRating = doubleVal
        } else {
            strRating = 0.0
        }
        
        // MARK: - Status
        if let value = dictionary["status"] as? String {
            status = value
        } else {
            status = ""
        }
        
        // MARK: - Type
        if let value = dictionary["type"] as? String {
            type = value
        } else {
            type = ""
        }
        
        // MARK: - isActive
        if let value = dictionary["is_active"] as? Int {
            isActive = value
        } else if let value = dictionary["is_active"] as? String, let intVal = Int(value) {
            isActive = intVal
        } else {
            isActive = 0
        }
        
        // MARK: - isBided
        if let value = dictionary["is_bided"] as? Int {
            isBided = value
        } else if let value = dictionary["is_bided"] as? String, let intVal = Int(value) {
            isBided = intVal
        } else {
            isBided = 0
        }
        
        // MARK: - Payment ID
        if let value = dictionary["payment_id"] as? String {
            paymentID = value
        } else {
            paymentID = ""
        }
        
        if let value = dictionary["review"] as? String {
            strReview = value
        } else {
            strReview = ""
        }
        
        // MARK: - User ID
        if let value = dictionary["user_id"] as? Int {
            userID = "\(value)"
        } else if let value = dictionary["user_id"] as? String {
            userID = value
        } else {
            userID = ""
        }
        
        // MARK: - User Name
        if let value = dictionary["user_name"] as? String {
            userName = value
        } else {
            userName = ""
        }
        
        // MARK: - User Image
        if let value = dictionary["user_image"] as? String {
            userImage = value
        } else {
            userImage = ""
        }
        
        // MARK: - Employee ID
        if let value = dictionary["employee_id"] as? Int {
            employeeID = "\(value)"
        } else if let value = dictionary["employee_id"] as? String {
            employeeID = value
        } else {
            employeeID = ""
        }
        
        // MARK: - Employee Name
        if let value = dictionary["employee_name"] as? String {
            employeeName = value
        } else {
            employeeName = ""
        }
        
        // MARK: - Employee Image
        if let value = dictionary["employee_image"] as? String {
            employeeImage = value
        } else {
            employeeImage = ""
        }
        
        // MARK: - Entry Date
        if let value = dictionary["entrydt"] as? String {
            entryDate = value
        } else {
            entryDate = ""
        }
    }
}
