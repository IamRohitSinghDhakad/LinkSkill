//
//  AddBankDetailViewController.swift
//  LinkSkill
//
//  Created by Rohit SIngh Dhakad on 02/11/25.
//

import UIKit

class AddBankDetailViewController: UIViewController {

    @IBOutlet weak var tfBankName: UITextField!
    @IBOutlet weak var tfAccountHolderName: UITextField!
    @IBOutlet weak var tfAccountNumber: UITextField!
    @IBOutlet weak var tfIFSCCode: UITextField!
    @IBOutlet weak var subVw: UIView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var tfEnterAmount: UITextField!
    
    var strAmount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subVw.isHidden = true
        call_WebService_GetBankDetails()
        
        self.lblText.text = "You have \(self.strAmount) in you wallet. Please enter amount you want to transfer in your account"
    }
    

    @IBAction func btnOnComplete(_ sender: Any) {
        call_WebService_SaveBankDetails()
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    @IBAction func btnCancelSubVw(_ sender: Any) {
        self.tfEnterAmount.text = ""
        self.subVw.isHidden = true
    }
    
    @IBAction func btnWithdrawl(_ sender: Any) {
        call_WebService_Withdrawl()
    }
}


extension AddBankDetailViewController{
    
    func call_WebService_GetBankDetails(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        var dictParam = [:] as [String:Any]
        
            dictParam = [
                "user_id": objAppShareData.UserDetail.strUserId!,
                "language": objAppShareData.currentLanguage]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetAccount, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [String: Any] {
                   let obj = AccountHolderModel(from: resultArray)
                    
                    self.tfBankName.text = obj.str_bank_name
                    self.tfIFSCCode.text = obj.str_ifsc
                    self.tfAccountNumber.text = obj.str_account_number
                    self.tfAccountHolderName.text = obj.str_holder_name
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            print("Error \(error)")
        }
    }
    
    func call_WebService_SaveBankDetails(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        var dictParam = [:] as [String:Any]
        
            dictParam = [
                "user_id": objAppShareData.UserDetail.strUserId!,
                "bank_name":self.tfBankName.text!,
                "holder_name":self.tfAccountHolderName.text!,
                "account_number":self.tfAccountNumber.text!,
                "ifsc":self.tfIFSCCode.text!]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_SaveAccount, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if response["result"] is [String: Any] {
                    self.subVw.isHidden = false
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            print("Error \(error)")
        }
    }
    
    
    func call_WebService_Withdrawl(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        var dictParam = [:] as [String:Any]
        
            dictParam = [
                "employee_id": objAppShareData.UserDetail.strUserId!,
                "amount":self.tfEnterAmount.text!,
                "language": objAppShareData.currentLanguage]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_withdrawal_request, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if response["result"] is [String: Any] {
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Success", message: message ?? "", controller: self) {
                        self.subVw.isHidden = true
                        self.tfEnterAmount.text = ""
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
