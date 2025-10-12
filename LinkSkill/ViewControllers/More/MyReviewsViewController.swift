//
//  MyReviewsViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit
import SDWebImage

class MyReviewsViewController: UIViewController {
    
    @IBOutlet weak var lblMyreiews: UILabel!
    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var vwRatinguser: FloatRatingView!
    @IBOutlet weak var tblvw: UITableView!
    @IBOutlet weak var lblTotalReviews: UILabel!
    
    
    var arrReviews = [MyReviewModel]()
    var obj = EmployeeReviewModel(from: [:])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblUserName.applyStyle(AppFonts.price18)
//        self.lblUserName.text = objAppShareData.UserDetail.name
//        self.imgVwUser.sd_setImage(with: URL(string: objAppShareData.UserDetail.userImage ?? ""), placeholderImage: UIImage(named: "ic_profile_placeholder"))
//        self.vwRatinguser.rating = Double(objAppShareData.UserDetail.rating ?? 1.0)
        
        self.tblvw.delegate = self
        self.tblvw.dataSource = self
        
        call_WebService_MyReviews()
        
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
}

extension MyReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewTableViewCell") as! MyReviewTableViewCell
        let obj = self.arrReviews[indexPath.row]
        cell.lblUserName.text = obj.reviewerName
        cell.lblDate.text = obj.entryDate
        cell.vwRatings.rating = Double(obj.rating ?? "0") ?? 0.0
        
        cell.imgVwUser.sd_setImage(with: URL(string: obj.reviewerImage ?? ""), placeholderImage: UIImage(named: "ic_profile_placeholder"))
        cell.lblDesc.text = obj.review
        
        return cell
    }
}

extension MyReviewsViewController {
    
    func call_WebService_MyReviews() {
        
        if !objWebServiceManager.isNetworkAvailable() {
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam: [String: Any] = [
            "employee_id": objAppShareData.UserDetail.strUserId ?? "",
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
            
            objWebServiceManager.hideIndicator()
            
            let status = response["status"] as? Int
            let message = response["message"] as? String
            
            if status == MessageConstant.k_StatusCode {
                
                if let responseDict = response as? [String: Any] {
                    print(responseDict)
                    
                    // Initialize main review model
                    self.obj = EmployeeReviewModel(from: responseDict)
                    
                    self.lblUserName.text = self.obj.employeeName
                    self.vwRatinguser.rating = Double(self.obj.avgRating ?? "0") ?? 0.0
                    self.lblTotalReviews.text = "(\(self.obj.totalReviews ?? "0"))"
                    self.imgVwUser.sd_setImage(with: URL(string: self.obj.employeeImage ?? ""), placeholderImage: UIImage(named: "ic_profile_placeholder"))
                    
                    // Clear and reload data
                    self.arrReviews.removeAll()
                    
                    if let resultArray = responseDict["result"] as? [[String: Any]] {
                        for dataDict in resultArray {
                            let review = MyReviewModel(from: dataDict)
                            self.arrReviews.append(review)
                        }
                    }
                    
                    if self.arrReviews.isEmpty {
                        self.tblvw.displayBackgroundText(text: "No Reviews Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                    } else {
                        self.tblvw.displayBackgroundText(text: "")
                    }
                    
                    self.tblvw.reloadData()
                    
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


