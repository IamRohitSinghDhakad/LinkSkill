//
//  ServiceHistoryViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit

class ServiceHistoryViewController: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var vwAccepted: UIView!
    @IBOutlet weak var vwCompleted: UIView!
    @IBOutlet weak var tblVw: UITableView!
    
    var arrJobs = [JobsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHeader.applyStyle(AppFonts.title)
        self.vwAccepted.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(1.0)   // Full color
        self.vwCompleted.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)  // 50% opacity
        setupTableView()
        call_WebService_ServiceHistory(strStatus: "Accepted")
    }
    
    private func setupTableView() {
        // Register nib
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tblVw.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        // Set delegates
        tblVw.delegate = self
        tblVw.dataSource = self
        
        tblVw.rowHeight = UITableView.automaticDimension
        tblVw.estimatedRowHeight = 60
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
    @IBAction func btnAccepted(_ sender: Any) {
        vwAccepted.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(1.0)   // Full color
        vwCompleted.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)  // 50% opacity
        call_WebService_ServiceHistory(strStatus: "Accepted")
    }
    
    @IBAction func btnCompleted(_ sender: Any) {
        vwAccepted.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)   // 50% opacity
        vwCompleted.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(1.0)  // Full color
        call_WebService_ServiceHistory(strStatus: "Completed")
    }
    
}

extension ServiceHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        let obj = arrJobs[indexPath.row]
        
        cell.lbltitle.text = obj.userName
        let symbol = (obj.currency?.uppercased() == "USD") ? "$" : "€"
        cell.lblEuros.text = "\(symbol)\(obj.price?.formattedPrice ?? "") \(obj.currency ?? "")"
        cell.lblServicetype.text = "\(obj.type ?? "")"
        cell.lblDescription.text = "Description Services: \(obj.details ?? "")"
        
        // MARK: - Show/Hide "Already Bid" label
        if obj.isBided == 1 && obj.status?.caseInsensitiveCompare("Pending") == .orderedSame {
            cell.vwAlreadyBid.isHidden = false
        } else {
            cell.vwAlreadyBid.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped on: \(arrJobs[indexPath.row])")
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "JobDetailsViewController")as! JobDetailsViewController
        vc.isComingFrom = "Employee"
        vc.objJobDetails = arrJobs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ServiceHistoryViewController {
    // MARK: - Webservice Call
    func call_WebService_ServiceHistory(strStatus: String) {
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "employee_id": objAppShareData.UserDetail.strUserId!,
            "language": "en",
            "status":strStatus]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getJobs, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [[String: Any]] {
                    print(response)
                    self.arrJobs.removeAll()
                    for data in resultArray{
                        let obj = JobsModel(from: data)
                        self.arrJobs.append(obj)
                    }
                    
                    if self.arrJobs.count == 0{
                        self.tblVw.displayBackgroundText(text: "No Jobs Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                    }else {
                        self.tblVw.displayBackgroundText(text: "")
                    }
                   // self.refreshControl.endRefreshing()
                    self.tblVw.reloadData()
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
               // self.refreshControl.endRefreshing()
                if self.arrJobs.count == 0{
                    self.tblVw.displayBackgroundText(text: "No Jobs Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                }else {
                    self.tblVw.displayBackgroundText(text: "")
                }
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            //self.refreshControl.endRefreshing()
            print("Error \(error)")
        }
    }
    
}
