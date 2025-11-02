//
//  ApplyForJobViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 04/10/25.
//

import UIKit

class ApplyForJobViewController: UIViewController {
    
    @IBOutlet weak var lblPlaceBidOnTheService: UILabel!
    @IBOutlet weak var lblBidAmount: UILabel!
    @IBOutlet weak var lblHeadertitle: UILabel!
    @IBOutlet weak var lblCurrencySymbol: UILabel!
    @IBOutlet weak var tfBidAmount: UITextField!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblTheServiceWillbe: UILabel!
    @IBOutlet weak var tfDays: UITextField!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblDescribeYourProposal: UILabel!
    @IBOutlet weak var txtVeProposal: RDTextView!
    
    var objJobDetails: JobsModel?
    var onJobApplied: ((_ updatedJob: JobsModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
    }
    
    func setUpUI() {
        self.lblHeadertitle.text = "Apply for Job"
        self.lblPlaceBidOnTheService.text = "Place a bid on the service"
        self.lblBidAmount.text = "Bid amount"
        let symbol = (objJobDetails!.currency?.uppercased() == "USD") ? "$" : "€"
        self.lblCurrencySymbol.text = symbol
        if symbol == "$"{
            self.lblCurrency.text = "USD"
        }else{
            self.lblCurrency.text = "EUR"
        }
        
        
        self.lblHeadertitle.applyStyle(AppFonts.title)
        self.lblPlaceBidOnTheService.applyStyle(AppFonts.title_regular)
        self.lblBidAmount.applyStyle(AppFonts.subtitle)
        self.lblCurrency.applyStyle(AppFonts.subtitle)
        self.lblTheServiceWillbe.applyStyle(AppFonts.subtitle)
        self.tfDays.applyStyle(AppFonts.subtitle)
        self.lblDays.applyStyle(AppFonts.subtitle)
        self.lblDescribeYourProposal.applyStyle(AppFonts.title_regular)
        self.txtVeProposal.applyStyle(AppFonts.subtitle)
    }
    
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
    @IBAction func btnOnApplyForJob(_ sender: Any) {
        if validateFields() {
            self.call_WebService_ApplyForJobs()
        }
    }
    
}

// MARK: - Validation
extension ApplyForJobViewController {
    private func validateFields() -> Bool {
        guard let bidAmount = tfBidAmount.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let days = tfDays.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let proposal = txtVeProposal.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return false
        }
        
        if bidAmount.isEmpty {
            showAlert(message: "Please enter your bid amount.")
            return false
        }
        
        if days.isEmpty {
            showAlert(message: "Please enter the number of days required.")
            return false
        }
        
        if proposal.isEmpty {
            showAlert(message: "Please describe your proposal.")
            return false
        }
        
        return true
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Missing Information",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension ApplyForJobViewController {
    
    func call_WebService_ApplyForJobs(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "job_id": objJobDetails?.id ?? "",
            "employee_id": objAppShareData.UserDetail.strUserId!,
            "bid_amount": tfBidAmount.text ?? "",
            "delivery_time": tfDays.text ?? "",
            "proposal": txtVeProposal.text ?? "",
            "language": objAppShareData.currentLanguage]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_place_bid, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if response["result"] is [String: Any] {
                    // ✅ Type confirmed — now safely unwrap
                    let resultDict = response["result"] as! [String: Any]
                    
                    self.objJobDetails?.isBided = 1
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Success", message: message ?? "", controller: self) {
                        if let updatedJob = self.objJobDetails {
                            self.onJobApplied?(updatedJob)
                        }
                        self.navigationController?.popViewController(animated: true)
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
