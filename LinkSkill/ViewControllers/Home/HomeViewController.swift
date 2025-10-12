//
//  HomeViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    
    // Dummy data for testing
    var arrJobs = [JobsModel]()
    var arrMyCategorys: [CategoryModel] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.call_WebService_GetJobs()
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
    
    private func setupPullToRefresh() {
        // ✅ Step 3: Configure refresh control
        refreshControl.tintColor = .systemBlue
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing jobs...", attributes: [.foregroundColor: UIColor.gray])
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tblVw.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh(_ sender: UIRefreshControl) {
        // ✅ Step 4: Reload data from server
        self.call_WebService_GetJobs()
    }
}

// MARK: - UITableView Delegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        // Configure your cell here
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


extension HomeViewController {
    
    func call_WebService_GetJobs(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "employee_id": objAppShareData.UserDetail.strUserId!,
            "language": objAppShareData.currentLanguage,
            "status":"Pending"]as [String:Any]
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
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                self.refreshControl.endRefreshing()
                if self.arrJobs.count == 0{
                    self.tblVw.displayBackgroundText(text: "No Jobs Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                }else {
                    self.tblVw.displayBackgroundText(text: "")
                }
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            self.refreshControl.endRefreshing()
            print("Error \(error)")
        }
    }
}


extension Double {
    var formattedPrice: String {
        if floor(self) == self {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.2f", self)
        }
    }
}
