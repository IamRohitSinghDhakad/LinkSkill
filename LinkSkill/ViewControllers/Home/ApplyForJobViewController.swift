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
    @IBOutlet weak var btnApplyForJob: UIButton!
    
    var objJobDetails: JobsModel?
    var onJobApplied: ((_ updatedJob: JobsModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        self.setUpUI()
    }
    
    func setLocalization(){
        self.lblHeadertitle.text = L10n.applyForJob
        self.lblPlaceBidOnTheService.text = L10n.place_a_bid_on_this_service
        self.lblBidAmount.text = L10n.bidAmount
        self.lblTheServiceWillbe.text = L10n.this_service_will_be_delivered_in
        self.lblDescribeYourProposal.text = L10n.describeYourProposal
        self.lblDays.text = L10n.days_s
        
        self.btnApplyForJob.setLocalizedTitle(L10n.applyForJob)
        
    }
    
    func setUpUI() {
//        self.lblHeadertitle.text = "Apply for Job"
//        self.lblPlaceBidOnTheService.text = "Place a bid on the service"
//        self.lblBidAmount.text = "Bid amount"
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
            showAlert(message: L10n.enterBidAmount)
            return false
        }
        
        if days.isEmpty {
            showAlert(message: L10n.enterDeliveryDays)
            return false
        }
        
        if proposal.isEmpty {
            showAlert(message: L10n.enterProposal)
            return false
        }
        
        return true
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.ok, style: .default))
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
                   
                    let resultDict = response["result"] as! [String: Any]
                    
                    self.objJobDetails?.isBided = 1
                    objAlert.showAlertSingleButtonCallBack(alertBtn: L10n.ok, title: L10n.success, message: message ?? "", controller: self) {
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
