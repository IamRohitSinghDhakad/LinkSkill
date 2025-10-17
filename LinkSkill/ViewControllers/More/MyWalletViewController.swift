//
//  MyWalletViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit

class MyWalletViewController: UIViewController {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblWalletAmount: UILabel!
    @IBOutlet weak var tblVw: UITableView!
    
    var arrTransactionList:[MyWalletModel] = []
    private let refreshControl = UIRefreshControl()
    var isComingFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblVw.delegate = self
        self.tblVw.dataSource = self
       
        self.call_WebService_GetWallet()
        setupPullToRefresh()
    }
    
    private func setupPullToRefresh() {
        // ✅ Step 3: Configure refresh control
        refreshControl.tintColor = .systemBlue
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Transactions...", attributes: [.foregroundColor: UIColor.gray])
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tblVw.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh(_ sender: UIRefreshControl) {
        // ✅ Step 4: Reload data from server
        self.call_WebService_GetWallet()
    }

    @IBAction func btnOnBack(_ sender: UIButton) {
        onBackPressed()
        
    }
    
    @IBAction func btnOnWithdrawl(_ sender: UIButton) {
        
    }
}

extension MyWalletViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTransactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWalletTableViewCell") as! MyWalletTableViewCell
        
        let obj = arrTransactionList[indexPath.row]
        cell.lblDateTime.text = obj.entryDate
        cell.lblDescription.text = obj.descriptionText
        cell.lblAmount.text = obj.amountText
        
        return cell
    }
}

extension MyWalletViewController{

    func call_WebService_GetWallet(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        var dictParam = [:] as [String:Any]
        
        if self.isComingFrom == "Employee"{
             dictParam = [
                "employee_id": objAppShareData.UserDetail.strUserId!,
                "language": "en"]as [String:Any]
        }else{
             dictParam = [
                "user_id": objAppShareData.UserDetail.strUserId!,
                "language": "en"]as [String:Any]
        }
        
        print(dictParam)
        
       
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_get_wallet, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [[String: Any]] {
                    print(response)
                   self.arrTransactionList.removeAll()
                    for data in resultArray{
                        let obj = MyWalletModel(from: data)
                        self.arrTransactionList.append(obj)
                    }
                    
                    self.lblWalletAmount.text = "\(response["total_amount"] as! String)"
                    if self.arrTransactionList.count == 0{
                        self.tblVw.displayBackgroundText(text: "No Transactions Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                    }else {
                        self.tblVw.displayBackgroundText(text: "")
                    }
                    self.refreshControl.endRefreshing()
                    self.tblVw.reloadData()
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                self.refreshControl.endRefreshing()
                if self.arrTransactionList.count == 0{
                    self.tblVw.displayBackgroundText(text: "No Transactions Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
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

    
    
