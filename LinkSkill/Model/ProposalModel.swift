//
//  ProposalModel.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 16/10/25.
//
import Foundation

class BidProposalModel: NSObject {
    
    var price: Double?
    var currency: String?
    var deliveryTime: String?
    var employeeEmail: String?
    var employeeId: String?
    var employeeMobile: String?
    var employeeName: String?
    var employeeProfile: String?
    var entryDate: String?
    var id: String?
    var jobId: String?
    var proposal: String?
    var rating: String?
    var reviewCount: String?
    var status: String?
    var type: String?
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        // MARK: - Bid Amount
        // MARK: - Price
        if let value = dictionary["bid_amount"] as? Double {
            price = value
        } else if let value = dictionary["bid_amount"] as? Int {
            price = Double(value)
        } else if let value = dictionary["bid_amount"] as? String, let doubleVal = Double(value) {
            price = doubleVal
        } else {
            price = 0.0
        }
        
        // MARK: - Currency
        if let value = dictionary["currency"] as? String {
            currency = value
        } else {
            currency = ""
        }
        
        // MARK: - Delivery Time
        if let value = dictionary["delivery_time"] as? Int {
            deliveryTime = "\(value)"
        } else if let value = dictionary["delivery_time"] as? String {
            deliveryTime = value
        } else {
            deliveryTime = ""
        }
        
        // MARK: - Employee Email
        if let value = dictionary["employee_email"] as? String {
            employeeEmail = value
        } else {
            employeeEmail = ""
        }
        
        // MARK: - Employee ID
        if let value = dictionary["employee_id"] as? Int {
            employeeId = "\(value)"
        } else if let value = dictionary["employee_id"] as? String {
            employeeId = value
        } else {
            employeeId = ""
        }
        
        // MARK: - Employee Mobile
        if let value = dictionary["employee_mobile"] as? Int {
            employeeMobile = "\(value)"
        } else if let value = dictionary["employee_mobile"] as? String {
            employeeMobile = value
        } else {
            employeeMobile = ""
        }
        
        // MARK: - Employee Name
        if let value = dictionary["employee_name"] as? String {
            employeeName = value
        } else {
            employeeName = ""
        }
        
        // MARK: - Employee Profile
        if let value = dictionary["employee_profile"] as? String {
            employeeProfile = value
        } else {
            employeeProfile = ""
        }
        
        // MARK: - Entry Date
        if let value = dictionary["entrydt"] as? String {
            entryDate = value
        } else {
            entryDate = ""
        }
        
        // MARK: - ID
        if let value = dictionary["id"] as? Int {
            id = "\(value)"
        } else if let value = dictionary["id"] as? String {
            id = value
        } else {
            id = ""
        }
        
        // MARK: - Job ID
        if let value = dictionary["job_id"] as? Int {
            jobId = "\(value)"
        } else if let value = dictionary["job_id"] as? String {
            jobId = value
        } else {
            jobId = ""
        }
        
        // MARK: - Proposal
        if let value = dictionary["proposal"] as? String {
            proposal = value
        } else {
            proposal = ""
        }
        
        // MARK: - Rating
        if let value = dictionary["rating"] as? String {
            rating = value
        } else if let value = dictionary["rating"] as? Double {
            rating = "\(value)"
        } else {
            rating = ""
        }
        
        // MARK: - Review Count
        if let value = dictionary["review_count"] as? Int {
            reviewCount = "\(value)"
        } else if let value = dictionary["review_count"] as? String {
            reviewCount = value
        } else {
            reviewCount = ""
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
    }
}
