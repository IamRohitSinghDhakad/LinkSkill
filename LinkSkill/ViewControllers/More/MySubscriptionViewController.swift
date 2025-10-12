//
//  MySubscriptionViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit
import SDWebImage

class MySubscriptionViewController: UIViewController {

    @IBOutlet weak var cvPlans: UICollectionView!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var lblMonthlyPlan: UILabel!
    @IBOutlet weak var lblCurrentPlan: UILabel!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    var arrPlans = [MySubscriptionModel]()
    var selectedIndex: Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHeaderTitle.applyStyle(AppFonts.title)
        self.lblMonthlyPlan.applyStyle(AppFonts.subtitle_regular_12)
        self.lblCurrentPlan.applyStyle(AppFonts.subtitle_regular_12)
        
        self.imgVwProfile.sd_setImage(with: URL(string: objAppShareData.UserDetail.userImage ?? ""), placeholderImage: UIImage(named: "ic_profile_placeholder"))
        
        self.cvPlans.delegate = self
        self.cvPlans.dataSource = self
        call_WebService_GetPlans()
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
   
    @IBAction func btnOnSubscribe(_ sender: Any) {
        
    }
}

extension MySubscriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPlans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MySubscriptionCollectionViewCell", for: indexPath) as! MySubscriptionCollectionViewCell
        
        let plan = arrPlans[indexPath.row]
        let isSelected = (indexPath.row == selectedIndex)
        cell.configureCell(with: plan, isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}

extension MySubscriptionViewController {
    
    func call_WebService_GetPlans(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "user_id": objAppShareData.UserDetail.strUserId!,
            "language": objAppShareData.currentLanguage]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_get_subscription, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [[String: Any]] {
                    print(response)
                    self.arrPlans.removeAll()
                    for data in resultArray{
                        let obj = MySubscriptionModel(from: data)
                        if obj.isSelected == true {
                            self.lblCurrentPlan.text = "Your Current Plan is \(obj.name ?? "")"
                        }
                        self.arrPlans.append(obj)
                    }
                    
                    if self.arrPlans.count == 0{
                        self.cvPlans.displayBackgroundText(text: "No Plans Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                    }else {
                        self.cvPlans.displayBackgroundText(text: "")
                    }
                   
                    self.cvPlans.reloadData()
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
               
                if self.arrPlans.count == 0{
                    self.cvPlans.displayBackgroundText(text: "No Plans Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                }else {
                    self.cvPlans.displayBackgroundText(text: "")
                }
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
          
            print("Error \(error)")
        }
    }
    
}
