//
//  JobDetailsViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 04/10/25.
//

import UIKit
import SDWebImage

class JobDetailsViewController: UIViewController {
    
    @IBOutlet weak var subVw: UIView!
    @IBOutlet weak var lblHeadertitle: UILabel!
    @IBOutlet weak var lblServicetypetitle: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var lblEuro: UILabel!
    @IBOutlet weak var lblDescriptionServiceTitle: UILabel!
    @IBOutlet weak var lblDescriptionService: UILabel!
    @IBOutlet weak var lblDescriptionServiceHeading: UILabel!
    @IBOutlet weak var lblApplyNow: UILabel!
    @IBOutlet weak var btnOnApplyNow: UIButton!
    @IBOutlet weak var tblVwDescreiptionServices: UITableView!
    @IBOutlet weak var vwAwardedEmployee: UIView!
    @IBOutlet weak var vwAwardedEmployeer: UIView!
    @IBOutlet weak var tblVwhgtConstant: NSLayoutConstraint!
    @IBOutlet weak var vwApplyForJob: UIView!
    @IBOutlet weak var lblAwardedEmployeeTitle: UILabel!
    @IBOutlet weak var lblEmployeeAwardedName: UILabel!
    @IBOutlet weak var imgVwAwardedEmployee: UIImageView!
    @IBOutlet weak var lblNameEmployerAwardedName: UILabel!
    @IBOutlet weak var lblEmployerAwardedTitle: UILabel!
    @IBOutlet weak var imgVwAwardedEmployer: UIImageView!
    @IBOutlet weak var vwCreateMilestone: UIView!
    @IBOutlet weak var tfEnterAmount: UITextField!
    @IBOutlet weak var btnContinueMileStone: UIButton!
    
    @IBOutlet weak var vwCompleted: UIView!
    @IBOutlet weak var lblEmployeeNameCompleted: UILabel!
    @IBOutlet weak var imgVwEmployeeCompleted: UIImageView!
    @IBOutlet weak var ratingVwCompletedEmployee: FloatRatingView!
    @IBOutlet weak var lblCommentEmployeeCompleted: UILabel!
    
    var isComingFrom = ""
    var objJobDetails: JobsModel?
    var arrServices = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.arrServices.removeAll()
        self.setUpUI()
    }
    
    func setUpUI(){
        self.subVw.isHidden = true
        self.lblHeadertitle.applyStyle(AppFonts.title)
        self.lblServicetypetitle.applyStyle(AppFonts.title_regular)
        self.lblDescriptionServiceTitle.applyStyle(AppFonts.title_regular)
        self.lblDescriptionServiceHeading.applyStyle(AppFonts.title_regular)
        self.lblApplyNow.applyStyle(AppFonts.subtitle)
        self.lblServiceType.applyStyle(AppFonts.subtitle_regular_12)
        self.lblDescriptionService.applyStyle(AppFonts.subtitle_regular_12)
        self.btnOnApplyNow.applyStyle(AppFonts.title_regular)
        self.lblEuro.applyStyle(AppFonts.price18)
        
        self.vwAwardedEmployee.isHidden = true
        self.vwAwardedEmployeer.isHidden = true
        self.vwCompleted.isHidden = true
        
        if self.isComingFrom == "Employee"{
            
            self.lblApplyNow.text = "Apply now if you have\nthe requier skill"
            self.btnOnApplyNow.setTitle("Apply Now", for: .normal)
            
            self.lblServiceType.text = "\(self.objJobDetails?.type ?? "")"
            self.lblDescriptionService.text = "\(self.objJobDetails?.details ?? "")"
            let symbol = (objJobDetails?.currency?.uppercased() == "USD") ? "$" : "€"
            self.lblEuro.text = "\(symbol)\(objJobDetails?.price?.formattedPrice ?? "") \(objJobDetails?.currency ?? "")"
            
            if let categories = self.objJobDetails?.categoryName {
                let categoryArray = categories
                    .components(separatedBy: ",")        // Split by comma
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } // Remove extra spaces
                self.arrServices.append(contentsOf: categoryArray)
            }
            
            self.tblVwDescreiptionServices.reloadData()
            self.updateTableHeight()
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            if let status = objJobDetails?.status,
               (status == "Accepted" || status == "Completed" || status == "Awarded"),
               let employeeName = objJobDetails?.employeeName,
               !employeeName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.vwAwardedEmployee.isHidden = false
                self.lblEmployeeAwardedName.text = employeeName
                if let imageUrlString = objJobDetails?.employeeImage,
                   !imageUrlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   let imageUrl = URL(string: imageUrlString) {
                    self.imgVwAwardedEmployee.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
                } else {
                    self.imgVwAwardedEmployee.image = UIImage(named: "placeholder")
                }
            } else {
                self.vwAwardedEmployee.isHidden = true
            }
            
            if objJobDetails?.isBided == 1{
                self.vwApplyForJob.isHidden = true
            }else{
                self.vwApplyForJob.isHidden = false
            }
        }else{
            self.lblApplyNow.text = "Applyed proposals on my\nopen service request"
            self.btnOnApplyNow.setTitle("Proposals", for: .normal)
            
            self.lblServiceType.text = "\(self.objJobDetails?.type ?? "")"
            self.lblDescriptionService.text = "\(self.objJobDetails?.details ?? "")"
            let symbol = (objJobDetails?.currency?.uppercased() == "USD") ? "$" : "€"
            self.lblEuro.text = "\(symbol)\(objJobDetails?.price?.formattedPrice ?? "") \(objJobDetails?.currency ?? "")"
            
            if let categories = self.objJobDetails?.categoryName {
                let categoryArray = categories
                    .components(separatedBy: ",")        // Split by comma
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } // Remove extra spaces
                self.arrServices.append(contentsOf: categoryArray)
            }
            
            self.tblVwDescreiptionServices.reloadData()
            self.updateTableHeight()
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            if objJobDetails?.status == "Awarded"{
                self.vwApplyForJob.isHidden = false
                self.imgVwAwardedEmployee.sd_setImage(with: URL(string: objJobDetails?.employeeImage ?? ""), placeholderImage: UIImage(named: "logo"))
                self.lblEmployeeAwardedName.text = objJobDetails?.employeeName
                
                self.vwAwardedEmployee.isHidden = false
                self.vwAwardedEmployeer.isHidden = true
                
            }else if objJobDetails?.status == "Accepted"{
                self.vwApplyForJob.isHidden = true
                self.imgVwAwardedEmployer.sd_setImage(with: URL(string: objJobDetails?.employeeImage ?? ""), placeholderImage: UIImage(named: "logo"))
                self.lblNameEmployerAwardedName.text = objJobDetails?.employeeName
                
                self.vwAwardedEmployee.isHidden = true
                self.vwAwardedEmployeer.isHidden = false
            }else if objJobDetails?.status == "Pending"{
                self.vwCompleted.isHidden = true
            }else{
              //  self.call_WebService_MyReviews(strEmployeeID: objJobDetails?.employeeID ?? "")
                self.vwApplyForJob.isHidden = true
                self.vwCompleted.isHidden = false
                self.imgVwEmployeeCompleted.sd_setImage(with: URL(string: objJobDetails?.employeeImage ?? ""), placeholderImage: UIImage(named: "logo"))
                self.lblEmployeeNameCompleted.text = objJobDetails?.employeeName
                self.ratingVwCompletedEmployee.rating = 3.5
                //self.lblCommentEmployeeCompleted.text =  ""
                
            }
            
        }
    }
    
    private func setupTableView() {
        // Register nib
        let nib = UINib(nibName: "JobDetailDescriptionServicesTableViewCell", bundle: nil)
        tblVwDescreiptionServices.register(nib, forCellReuseIdentifier: "JobDetailDescriptionServicesTableViewCell")
        // Set delegates
        tblVwDescreiptionServices.delegate = self
        tblVwDescreiptionServices.dataSource = self
    }
    
    
    @IBAction func btnOnback(_ sender: Any) {
        self.onBackPressed()
    }
    
    
    @IBAction func btnApplyNow(_ sender: Any) {
        if isComingFrom == "Employee" {
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "ApplyForJobViewController") as! ApplyForJobViewController
            vc.objJobDetails = self.objJobDetails
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProposalViewController") as! ProposalViewController
            vc.objJobDetails = self.objJobDetails
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    @IBAction func btnOnWhatIsMilestone(_ sender: Any) {
        
    }
    
    @IBAction func btnOnCreateMilestone(_ sender: Any) {
        self.subVw.isHidden = false
    }
    
    @IBAction func btnOnMarkAsComplete(_ sender: Any) {
        self.call_WebService_UpdaetJobStatus()
    }
    
    @IBAction func btnOnCloseSubve(_ sender: Any) {
        self.subVw.isHidden = true
    }
    
    @IBAction func btnOnCreateMileStone(_ sender: Any) {
        
    }
}


extension JobDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailDescriptionServicesTableViewCell") as? JobDetailDescriptionServicesTableViewCell {
            
            cell.lbltitle.text = arrServices[indexPath.row]
            
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    private func updateTableHeight() {
        tblVwDescreiptionServices.layoutIfNeeded() // Ensure layout is updated
        let rowHeight: CGFloat = 40 // or your estimated/fixed row height
        tblVwhgtConstant.constant = rowHeight * CGFloat(arrServices.count)
    }
    
}

extension JobDetailsViewController {
    
    
    func call_WebService_UpdaetJobStatus(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "employee_id": self.objJobDetails?.employeeID ?? "",
            "job_id": self.objJobDetails?.id ?? "",
            "language": objAppShareData.currentLanguage,
            "status": "Completed"
        ]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_update_job_status, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
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
            
        }
    }
    
    
    func call_WebService_CreateMileStone(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "amount": self.tfEnterAmount.text!,
            "job_id": self.objJobDetails?.id ?? "",
            "language": objAppShareData.currentLanguage,
            "currency": "USD"
        ]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_Create_Payment, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [String: Any] {
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Success", message: message ?? "", controller: self) {
                        self.tfEnterAmount.text = ""
                        self.subVw.isHidden = true
                    }
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            
        }
    }
    
    
    func call_WebService_MyReviews(strEmployeeID: String){
        
        if !objWebServiceManager.isNetworkAvailable() {
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam: [String: Any] = [
            "employee_id": strEmployeeID,
            "language": objAppShareData.currentLanguage
        ]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(
            strURL: WsUrl.url_get_review,
            queryParams: [:],
            params: dictParam,
            strCustomValidation: "",
            showIndicator: false
        ) { response in
            print(response)
            objWebServiceManager.hideIndicator()
            
            let status = response["status"] as? Int
            let message = response["message"] as? String
            
            if status == MessageConstant.k_StatusCode {
                
                if let responseDict = response as? [String: Any] {
                    print(responseDict)
                    
                    if let resultArray = responseDict["result"] as? [[String: Any]] {
//                        for dataDict in resultArray {
//                            let review = MyReviewModel(from: dataDict)
//                            self.arrReviews.append(review)
//                        }
                    }
                    
//                    if self.arrReviews.isEmpty {
//                        self.tblvw.displayBackgroundText(text: "No Reviews Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
//                    } else {
//                        self.tblvw.displayBackgroundText(text: "")
//                    }
                    
                   // self.tblvw.reloadData()
                    
                } else {
                    objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                }
                
            } else {
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
            
        } failure: { error in
            objWebServiceManager.hideIndicator()
            print("Error: \(error)")
        }
    }
}
