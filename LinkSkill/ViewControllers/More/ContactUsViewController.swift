//
//  ContactUsViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var txtVwMsg: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblHeading.applyStyle(AppFonts.title)
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
    @IBAction func btnOnSubmit(_ sender: Any) {
        // Trim whitespaces to prevent empty-space submissions
           let email = tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let message = txtVwMsg.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           
           // Validate email field
           guard !email.isEmpty else {
               objAlert.showAlert(message: "Please enter subject", title: "Alert", controller: self)
               return
           }
           
           // Validate message field
           guard !message.isEmpty else {
               objAlert.showAlert(message: "Please enter your message.", title: "Alert", controller: self)
               return
           }
           
           // ✅ All validations passed — proceed with submission
           print("Subject: \(email)")
           print("Message: \(message)")
           
        self.call_WebService_ContactUs(strSubject: email, strDescription: message)
    }
    
}


extension ContactUsViewController{
  
    func call_WebService_ContactUs(strSubject: String, strDescription:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "user_id": objAppShareData.UserDetail.strUserId!,
            "subject": strSubject,
            "message": strDescription,
            "language": objAppShareData.currentLanguage]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_contact_us, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [String: Any] {
                   
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Success", message: message ?? "", controller: self) {
                        self.onBackPressed()
                    }
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            print("Error \(error)")
        }
    }
    
}
    
