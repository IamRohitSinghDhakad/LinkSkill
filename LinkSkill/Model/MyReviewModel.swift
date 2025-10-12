//
//  MyReviewModel.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 12/10/25.
//

import UIKit

class EmployeeReviewModel: NSObject {
    
    var avgRating: String?
    var employeeImage: String?
    var employeeName: String?
    var message: String?
    var status: String?
    var totalReviews: String?
    var arrReviews: [MyReviewModel] = []
    
    init(from dictionary: [String: Any]) {
        super.init()
        
        if let value = dictionary["avg_rating"] as? Double {
            avgRating = "\(value)"
        } else if let value = dictionary["avg_rating"] as? String {
            avgRating = value
        } else {
            avgRating = ""
        }
        
        if let value = dictionary["employee_image"] as? String {
            employeeImage = value
        } else {
            employeeImage = ""
        }
        
        if let value = dictionary["employee_name"] as? String {
            employeeName = value
        } else {
            employeeName = ""
        }
        
        if let value = dictionary["message"] as? String {
            message = value
        } else {
            message = ""
        }
        
        if let value = dictionary["status"] as? Int {
            status = "\(value)"
        } else if let value = dictionary["status"] as? String {
            status = value
        } else {
            status = ""
        }
        
        if let value = dictionary["total_reviews"] as? Int {
            totalReviews = "\(value)"
        } else if let value = dictionary["total_reviews"] as? String {
            totalReviews = value
        } else {
            totalReviews = ""
        }
        
        if let resultArray = dictionary["result"] as? [[String: Any]] {
            for obj in resultArray {
                let model = MyReviewModel(from: obj)
                arrReviews.append(model)
            }
        }
    }
}

class MyReviewModel: NSObject {
    
    var reviewId: String?
       var reviewerId: String?
       var reviewerName: String?
       var reviewerImage: String?
       var jobType: String?
       var review: String?
       var rating: String?
       var entryDate: String?
       
       init(from dictionary: [String: Any]) {
           super.init()
           
           if let value = dictionary["review_id"] as? Int {
               reviewId = "\(value)"
           } else if let value = dictionary["review_id"] as? String {
               reviewId = value
           } else {
               reviewId = ""
           }
           
           if let value = dictionary["reviewer_id"] as? Int {
               reviewerId = "\(value)"
           } else if let value = dictionary["reviewer_id"] as? String {
               reviewerId = value
           } else {
               reviewerId = ""
           }
           
           if let value = dictionary["reviewer_name"] as? String {
               reviewerName = value
           } else {
               reviewerName = ""
           }
           
           if let value = dictionary["reviewer_image"] as? String {
               reviewerImage = value
           } else {
               reviewerImage = ""
           }
           
           if let value = dictionary["job_type"] as? String {
               jobType = value
           } else {
               jobType = ""
           }
           
           if let value = dictionary["review"] as? String {
               review = value
           } else {
               review = ""
           }
           
           if let value = dictionary["rating"] as? Double {
               rating = "\(value)"
           } else if let value = dictionary["rating"] as? String {
               rating = value
           } else {
               rating = ""
           }
           
           if let value = dictionary["entrydt"] as? String {
               entryDate = value
           } else {
               entryDate = ""
           }
       }
   }
