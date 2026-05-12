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
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var tfEnterAmount: UITextField!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAccHolderName: UILabel!
    @IBOutlet weak var lblAccNumber: UILabel!
    @IBOutlet weak var btnWithdrawl: UIButton!
    @IBOutlet weak var lblIfsc: UILabel!
    @IBOutlet weak var btnComplete: UIButton!
    
    var strAmount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subVw.isHidden = true
        call_WebService_GetBankDetails()
        
        self.lblText.text = "\(L10n.you_have) \(self.strAmount) \(L10n.usd_in_your_wallet_n_nplease_enter_amount_you_want_to_transfer_in_your_account)"
        
        self.lblBankName.text = L10n.bankName
        self.lblAccHolderName.text = L10n.accountHolderName
        self.lblAccNumber.text = L10n.accountNumber
        self.lblIfsc.text = L10n.ifscCode
        self.lblHeading.text = L10n.addBankDetail
        
        self.tfAccountNumber.placeholder = L10n.enterAccountNumber
        self.tfBankName.placeholder = L10n.enterBankName
        self.tfAccountNumber.placeholder = L10n.enterAccountNumber
        self.tfIFSCCode.placeholder = L10n.enterIfscCode
        
        self.btnComplete.setLocalizedTitle(L10n.complete)
        self.btnWithdrawl.setLocalizedTitle(L10n.withdrawl)
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
               // objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
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
