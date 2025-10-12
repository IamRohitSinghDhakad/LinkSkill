//
//  EditSkillsViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit
import SDWebImage

class EditSkillsViewController: UIViewController {
    
    var arrCategory = [CategoryModel]()
    @IBOutlet weak var cvCategory: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cvCategory.delegate = self
        self.cvCategory.dataSource = self
        
        call_WebService_GetCategory()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnComplete(_ sender: Any) {
        // Filter only selected categories
        let selectedCategories = arrCategory.filter { $0.isSelected == 1 }.compactMap { String($0.id ?? "") }
        // Join them with commas
        let commaSeparatedIds = selectedCategories.joined(separator: ",")
        
        self.call_WebService_UpdateCategory(strCategoryID: commaSeparatedIds)
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
    
}

extension EditSkillsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditSkillCollectionViewCell", for: indexPath) as! EditSkillCollectionViewCell
        let obj = self.arrCategory[indexPath.row]
        cell.lblTitle.text = obj.name
        
        cell.imgVw.sd_setImage(with: URL(string: obj.image ?? ""), placeholderImage: UIImage(named: "logo"))
        
        // Show or hide tick image based on selection state
        cell.imgVwTick.isHidden = (obj.isSelected == 0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Assuming 10 points spacing between cells
        let spacing: CGFloat = 10
        let totalSpacing = spacing * 10 // 3 cells = 4 spaces (left + right + between cells)
        
        let width = (collectionView.frame.width - totalSpacing) / 3
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let obj = self.arrCategory[indexPath.row]
        // Toggle selection state
        obj.isSelected = (obj.isSelected == 1) ? 0 : 1
        // Update model
        self.arrCategory[indexPath.row] = obj
        // Reload just that cell for smooth performance
        collectionView.reloadItems(at: [indexPath])
    }
}

extension EditSkillsViewController {
    
    func call_WebService_GetCategory(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "user_id": objAppShareData.UserDetail.strUserId!,
            "language": objAppShareData.currentLanguage]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getCategory, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [[String: Any]] {
                    print(response)
                    self.arrCategory.removeAll()
                    for data in resultArray{
                        let obj = CategoryModel(from: data)
                        self.arrCategory.append(obj)
                    }
                    if self.arrCategory.count == 0{
                        self.cvCategory.displayBackgroundText(text: "No Jobs Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                    }else {
                        self.cvCategory.displayBackgroundText(text: "")
                    }
                    self.cvCategory.reloadData()
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                if self.arrCategory.count == 0{
                    self.cvCategory.displayBackgroundText(text: "No Jobs Available", fontStyle: "ABeeZee-Regular", fontSize: 22)
                }else {
                    self.cvCategory.displayBackgroundText(text: "")
                }
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            print("Error \(error)")
        }
    }
    
    
    func call_WebService_UpdateCategory(strCategoryID: String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "user_id": objAppShareData.UserDetail.strUserId!,
            "category_id": strCategoryID,
            "language": objAppShareData.currentLanguage]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_update_profile, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
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
            print("Error \(error)")
        }
    }
    
}
