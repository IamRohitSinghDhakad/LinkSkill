//
//  ReviewRatingViewController.swift
//  LinkSkill
//
//  Created by Rohit SIngh Dhakad on 04/11/25.
//

import UIKit

class ReviewRatingViewController: UIViewController, FloatRatingViewDelegate {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var ratingVw: FloatRatingView!
    @IBOutlet weak var txtVwComments: RDTextView!
    
    var objJobDetails: JobsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ratingVw.delegate = self
    }
    
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }

    @IBAction func btnOnSubmit(_ sender: Any) {
        
        print(self.ratingVw.rating)
        
    }
    
    
    
    
    func call_WebService_UpdaetReview(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "employee_id": self.objJobDetails?.employeeID ?? "",
            "user_id": objAppShareData.UserDetail.strUserId ?? "",
            "job_id": self.objJobDetails?.id ?? "",
            "language": objAppShareData.currentLanguage,
            "rating": "",
            "review": self.txtVwComments.text!
        ]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_review_rating, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [String: Any] {
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Success", message: message ?? "", controller: self) {
                        
                    }
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            
        }
    }
}
