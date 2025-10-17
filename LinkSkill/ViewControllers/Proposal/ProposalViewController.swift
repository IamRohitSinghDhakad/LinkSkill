//
//  ProposalViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 16/10/25.
//

import UIKit
import SDWebImage

class ProposalViewController: UIViewController {
    
    @IBOutlet weak var tblvw: UITableView!
    
    var objJobDetails: JobsModel?
    
    var arrBidProposalModel = [BidProposalModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblvw.delegate = self
        self.tblvw.dataSource = self
        
        self.call_WebService_GetJobs(strJobID: objJobDetails?.id ?? "")
        
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
}

extension ProposalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBidProposalModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProposalTableViewCell") as!  ProposalTableViewCell
        
        let obj = arrBidProposalModel[indexPath.row]
        
        cell.imgVwUser.sd_setImage(with: URL(string: obj.employeeProfile ?? ""), placeholderImage: UIImage(named: "logo"))
        cell.lblUserName.text = obj.employeeName
        cell.lblDescription.text = obj.proposal
        cell.lblInDays.text = "In \(obj.deliveryTime ?? "") days"
        let symbol = (obj.currency?.uppercased() == "USD") ? "$" : "€"
        cell.lblPrice.text = "\(symbol)\(obj.price?.formattedPrice ?? "") \(obj.currency ?? "")"
        
        if let ratingValue = Double(obj.rating ?? "") {
            cell.lblRating.text = String(format: "%.1f", ratingValue)
        } else {
            cell.lblRating.text = "0.0"
        }
        
        cell.btnOnChat.tag = indexPath.row
        cell.btnOnChat.addTarget(self, action: #selector(btnOnChatTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnOnChatTapped(_ sender: UIButton) {
        let index = sender.tag
        let selectedObj = arrBidProposalModel[index]
        
        // ✅ Create instance of your chat view controller
        let chatVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController
        
        self.navigationController?.pushViewController(chatVC, animated: true)
    }

}


extension ProposalViewController {
    
    func call_WebService_GetJobs(strJobID: String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "job_id": strJobID,
            "language": objAppShareData.currentLanguage
        ]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_get_bids, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [[String: Any]] {
                    print(response)
                    self.arrBidProposalModel.removeAll()
                    for data in resultArray{
                        let obj = BidProposalModel(from: data)
                        self.arrBidProposalModel.append(obj)
                    }
                    
                    if self.arrBidProposalModel.count == 0{
                        self.tblvw.displayBackgroundText(text: "No Proposal Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                    }else {
                        self.tblvw.displayBackgroundText(text: "")
                    }
//                    self.refreshControl.endRefreshing()
                   self.tblvw.reloadData()
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                // self.refreshControl.endRefreshing()
                if self.arrBidProposalModel.count == 0{
                    self.tblvw.displayBackgroundText(text: "No Jobs Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                }else {
                    self.tblvw.displayBackgroundText(text: "")
                }
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            // self.refreshControl.endRefreshing()
            print("Error \(error)")
        }
    }
}
