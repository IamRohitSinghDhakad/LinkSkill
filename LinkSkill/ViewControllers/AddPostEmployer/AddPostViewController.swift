//
//  AddPostViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 15/10/25.
//

import UIKit

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var tfServiceType: UITextField!
    @IBOutlet weak var tfSkill: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfCurrency: UITextField!
    @IBOutlet weak var txtVwJobDetails: UITextView!
    @IBOutlet weak var subVw: UIView!
    @IBOutlet weak var tblvw: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    var arrCategory = [CategoryModel]()
    var filteredCategory = [CategoryModel]()
    var selectedIds = ""
    var selectedNames = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subVw.isHidden = true
        
        tfSearch.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        // Disable direct typing and add tap gesture to open action sheet
        tfCurrency.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(currencyFieldTapped))
        tfCurrency.addGestureRecognizer(tapGesture)
        
        call_WebService_GetCategory()
    }

    
    @IBAction func btnOnSkills(_ sender: Any) {
        self.subVw.isHidden = false
    }
    
    @IBAction func btnOnSubmit(_ sender: Any) {
        if validateFields() {
            self.call_WebService_AddPost()
        }
    }
    
    @objc private func currencyFieldTapped() {
        view.endEditing(true) // dismiss keyboard if any
        
        let alert = UIAlertController(title: "Select Currency", message: nil, preferredStyle: .actionSheet)
        
        let usdAction = UIAlertAction(title: "USD", style: .default) { _ in
            self.tfCurrency.text = "USD"
        }
        
        let eurAction = UIAlertAction(title: "EUR", style: .default) { _ in
            self.tfCurrency.text = "EUR"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(usdAction)
        alert.addAction(eurAction)
        alert.addAction(cancelAction)
        
        // For iPad support
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = tfCurrency
            popoverController.sourceRect = tfCurrency.bounds
        }
        
        present(alert, animated: true)
    }
    
    
    private func validateFields() -> Bool {
        // Trim whitespaces before validation
        let serviceType = tfServiceType.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let skill = tfSkill.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let price = tfPrice.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let currency = tfCurrency.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let jobDetails = txtVwJobDetails.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validation checks
        if serviceType.isEmpty {
            showAlert(message: "Please enter Service Type")
            return false
        }
        if skill.isEmpty {
            showAlert(message: "Please enter Skill")
            return false
        }
        if price.isEmpty {
            showAlert(message: "Please enter Price")
            return false
        }
        if currency.isEmpty {
            showAlert(message: "Please enter Currency")
            return false
        }
        if jobDetails.isEmpty {
            showAlert(message: "Please enter Job Details")
            return false
        }
        return true
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    @IBAction func btnOnCloseSubVw(_ sender: Any) {
        // Reset all selections when closing
        for i in 0..<arrCategory.count {
            arrCategory[i].isSelected = 0
        }
        filteredCategory = arrCategory
        tblvw.reloadData()
        self.subVw.isHidden = true
    }
    @IBAction func btnOnDOne(_ sender: Any) {
        let selected = arrCategory.filter { $0.isSelected == 1 }
        
        // Get comma-separated strings
        selectedIds = selected.compactMap { $0.id }.joined(separator: ",")
        selectedNames = selected.compactMap { $0.name }.joined(separator: ", ")
        
        // Set names to textfield
        tfSkill.text = selectedNames
        
        print("✅ Selected IDs: \(selectedIds)")
        print("✅ Selected Names: \(selectedNames)")
        
        self.subVw.isHidden = true
    }
    
    // MARK: - Search Filter
    
    @objc private func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        
        if searchText.isEmpty {
            filteredCategory = arrCategory
        } else {
            filteredCategory = arrCategory.filter {
                $0.name?.lowercased().contains(searchText) ?? false
            }
        }
        tblvw.reloadData()
    }
    
    
}

extension AddPostViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddPostTableViewCell", for: indexPath) as? AddPostTableViewCell else {
            return UITableViewCell()
        }
        
        let obj = filteredCategory[indexPath.row]
        cell.lblName.text = obj.name
        cell.imgVwTick.isHidden = (obj.isSelected == 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get selected item from filtered list
        let selectedObj = filteredCategory[indexPath.row]
        
        // Toggle its selection state
        selectedObj.isSelected = (selectedObj.isSelected == 1) ? 0 : 1
        
        // Update both filtered and main array consistently
        filteredCategory[indexPath.row] = selectedObj
        
        if let indexInMain = arrCategory.firstIndex(where: { $0.id == selectedObj.id }) {
            arrCategory[indexInMain].isSelected = selectedObj.isSelected
        }
        
        // Reload only this cell for smooth performance
        tblvw.reloadRows(at: [indexPath], with: .fade)
    }
    
}

extension AddPostViewController{
    
    func call_WebService_AddPost(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "user_id": objAppShareData.UserDetail.strUserId ?? "",
            "type": self.tfServiceType.text!,
            "category_id": "",
            "price": self.tfPrice.text!,
            "currency": self.tfCurrency.text!,
            "details": self.txtVwJobDetails.text!,
            "language": objAppShareData.currentLanguage
        ]as [String:Any]
        
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_create_job, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [String: Any] {
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "Success", message: message ?? "", controller: self) {
                        self.setRootController()
                    }
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            
        }
    }
    
    func setRootController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarEmployerViewController") as! TabBarEmployerViewController
        let navController = UINavigationController(rootViewController: homeViewController)
        navController.navigationBar.isHidden = true
        appDelegate.window?.rootViewController = navController
    }
    
    
    func call_WebService_GetCategory() {
           guard objWebServiceManager.isNetworkAvailable() else {
               objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
               return
           }
           
           objWebServiceManager.showIndicator()
           
           let dictParam: [String: Any] = [
               "user_id": objAppShareData.UserDetail.strUserId ?? "",
               "language": objAppShareData.currentLanguage
           ]
           
           objWebServiceManager.requestPost(strURL: WsUrl.url_getCategory, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
               objWebServiceManager.hideIndicator()
               
               let status = response["status"] as? Int
               if status == MessageConstant.k_StatusCode,
                  let resultArray = response["result"] as? [[String: Any]] {
                   
                   self.arrCategory.removeAll()
                   self.filteredCategory.removeAll()
                   
                   self.arrCategory = resultArray.map { CategoryModel(from: $0) }
                   self.filteredCategory = self.arrCategory
                   self.tblvw.reloadData()
               } else {
                   let message = response["message"] as? String ?? "Something went wrong"
                   objAlert.showAlert(message: message, title: "Alert", controller: self)
               }
           } failure: { error in
               objWebServiceManager.hideIndicator()
               print("❌ Error:", error)
           }
       }
    
}


extension AddPostViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfCurrency {
            currencyFieldTapped()
            return false // prevent keyboard
        }
        return true
    }
}
