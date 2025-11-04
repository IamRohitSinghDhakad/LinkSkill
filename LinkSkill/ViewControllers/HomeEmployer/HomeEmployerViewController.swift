//
//  HomeEmployerViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 15/10/25.
//

import UIKit
import SDWebImage

class HomeEmployerViewController: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var vwOpen: UIView!
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var vwActive: UIView!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var vwComplete: UIView!
    @IBOutlet weak var btnComplete: UIButton!
    
    var arrJobs = [JobsModel]()
    var arrMyCategorys: [CategoryModel] = []
    private let refreshControl = UIRefreshControl()
    
    var strStatus: String = "Pending"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPullToRefresh()
        
        self.vwOpen.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(1.0)   // Full color
        self.vwActive.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)  // 50% opacity
        self.vwComplete.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)   // Full color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.call_WebService_GetJobs(strStatus: self.strStatus)
    }
    
    private func setupTableView() {
        // Register nib
        let nib = UINib(nibName: "HomeEmployerTableViewCell", bundle: nil)
        tblVw.register(nib, forCellReuseIdentifier: "HomeEmployerTableViewCell")
        
        // Set delegates
        tblVw.delegate = self
        tblVw.dataSource = self
        
        tblVw.rowHeight = UITableView.automaticDimension
        tblVw.estimatedRowHeight = 60
    }
    
    private func setupPullToRefresh() {
        // ✅ Step 3: Configure refresh control
        refreshControl.tintColor = .systemBlue
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing jobs...", attributes: [.foregroundColor: UIColor.gray])
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tblVw.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh(_ sender: UIRefreshControl) {
        // ✅ Step 4: Reload data from server
        self.call_WebService_GetJobs(strStatus: self.strStatus)
    }

    @IBAction func btnOnOpen(_ sender: Any) {
        self.vwOpen.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(1.0)
        self.vwActive.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)
        self.vwComplete.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)
        self.strStatus = "Pending"
        self.call_WebService_GetJobs(strStatus: self.strStatus)
    }
    @IBAction func btnActive(_ sender: Any) {
        self.vwOpen.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)
        self.vwActive.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(1.0)
        self.vwComplete.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)
        self.strStatus = "Awarded,Accepted"
        self.call_WebService_GetJobs(strStatus: self.strStatus)
    }
    @IBAction func btnOnComplete(_ sender: Any) {
        self.vwOpen.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)
        self.vwActive.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)
        self.vwComplete.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(1.0)
        self.strStatus = "Completed"
        self.call_WebService_GetJobs(strStatus: self.strStatus)
        
    }
    
}

// MARK: - UITableView Delegate & DataSource
extension HomeEmployerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeEmployerTableViewCell", for: indexPath) as? HomeEmployerTableViewCell else {
            return UITableViewCell()
        }
        // Configure your cell here
        let obj = arrJobs[indexPath.row]
        
        let symbol = (obj.currency?.uppercased() == "USD") ? "$" : "€"
        cell.lblEuros.text = "\(symbol)\(obj.price?.formattedPrice ?? "") \(obj.currency ?? "")"
        cell.lblServicetype.text = "\(obj.type ?? "")"
        cell.lblDescription.text = "Description Services: \(obj.details ?? "")"
        cell.imgVw.sd_setImage(with: URL(string: obj.employeeImage ?? ""), placeholderImage: UIImage(named: "logo"))

        if self.strStatus == "Awarded,Accepted" || self.strStatus == "Completed"{
            cell.vwAwardedEmploye.isHidden = false
        }else{
            cell.vwAwardedEmploye.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped on: \(arrJobs[indexPath.row])")
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "JobDetailsViewController")as! JobDetailsViewController
        vc.isComingFrom = "Employer"
        vc.objJobDetails = arrJobs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HomeEmployerViewController{
    
    func call_WebService_GetJobs(strStatus: String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "user_id": objAppShareData.UserDetail.strUserId!,
            "language": objAppShareData.currentLanguage,
            "status": self.strStatus
        ]as [String:Any]
        
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
                    self.refreshControl.endRefreshing()
                    self.tblVw.reloadData()
                }
            }else{
                self.arrJobs.removeAll()
                self.tblVw.reloadData()
                //objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                self.refreshControl.endRefreshing()
                if self.arrJobs.count == 0{
                    self.tblVw.displayBackgroundText(text: "No Jobs Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                }else {
                    self.tblVw.displayBackgroundText(text: "")
                }
            }
        } failure: { (error) in
            self.arrJobs.removeAll()
            self.tblVw.reloadData()
            objWebServiceManager.hideIndicator()
            self.refreshControl.endRefreshing()
            print("Error \(error)")
        }
    }
    
}
