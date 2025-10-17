//
//  ProfileEmployerViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 15/10/25.
//

import UIKit
import SDWebImage

class ProfileEmployerViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfRate: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfPin: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    var objUser = UserModel(from: [:])
    var imagePicker = UIImagePickerController()
    var pickedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.call_WebService_Profile()
    }
    
    
    @IBAction func btnOpenImageView(_ sender: Any) {
        MediaPicker.shared.pickMedia(from: self) { image, dict in
            self.imgVwUser.image = image
            self.pickedImage = image
        }
    }
    
    @IBAction func btnSave(_ sender: Any) {
        // Trim all fields to remove unwanted spaces
           let name = tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let email = tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let mobile = tfMobile.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let rate = tfRate.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let country = tfCountry.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let state = tfState.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let city = tfCity.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let pin = tfPin.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           let address = tfAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           
           // Validate step by step for better UX messages
           guard !name.isEmpty else {
               objAlert.showAlert(message: "Please enter your name.", title: "Alert", controller: self)
               return
           }
           guard !email.isEmpty else {
               objAlert.showAlert(message: "Please enter your email.", title: "Alert", controller: self)
               return
           }
        guard isValidEmail(email) else {
               objAlert.showAlert(message: "Please enter a valid email address.", title: "Alert", controller: self)
               return
           }
           guard !mobile.isEmpty else {
               objAlert.showAlert(message: "Please enter your mobile number.", title: "Alert", controller: self)
               return
           }
           guard !rate.isEmpty else {
               objAlert.showAlert(message: "Please enter your rate.", title: "Alert", controller: self)
               return
           }
           guard !country.isEmpty else {
               objAlert.showAlert(message: "Please enter your country.", title: "Alert", controller: self)
               return
           }
           guard !state.isEmpty else {
               objAlert.showAlert(message: "Please enter your state.", title: "Alert", controller: self)
               return
           }
           guard !city.isEmpty else {
               objAlert.showAlert(message: "Please enter your city.", title: "Alert", controller: self)
               return
           }
           guard !pin.isEmpty else {
               objAlert.showAlert(message: "Please enter your pin code.", title: "Alert", controller: self)
               return
           }
           guard !address.isEmpty else {
               objAlert.showAlert(message: "Please enter your address.", title: "Alert", controller: self)
               return
           }
           
           // ✅ All validations passed — proceed with API call
           callWebserviceForUpdateProfile()
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
}

extension ProfileEmployerViewController{
    
    func call_WebService_Profile(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
            "login_user_id": objAppShareData.UserDetail.strUserId!,
            "language": objAppShareData.currentLanguage]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getUserProfile, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [String: Any] {
                    self.objUser = UserModel(from: resultArray)
                    
                    self.tfName.text = self.objUser.name
                    self.tfEmail.text = self.objUser.email
                    self.tfMobile.text = self.objUser.mobile
                    self.tfRate.text = self.objUser.strRate
                    self.tfCountry.text = self.objUser.strCountry
                    self.tfState.text = self.objUser.strState
                    self.tfCity.text = self.objUser.strCity
                    self.tfPin.text = self.objUser.strZipCode
                    self.tfAddress.text = self.objUser.address
                    self.imgVwUser.sd_setImage(with: URL(string: self.objUser.userImage ?? ""), placeholderImage: UIImage(named: "logo"))
                    
                    
                }
            }else{
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                
                
            }
        } failure: { (error) in
            objWebServiceManager.hideIndicator()
            
            print("Error \(error)")
        }
    }
    
    func callWebserviceForUpdateProfile(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        self.view.endEditing(true)
        
        var imageData = [Data]()
        var imgData : Data?
        if self.pickedImage != nil{
            imgData = (self.pickedImage?.jpegData(compressionQuality: 0.2))!
        }
        else {
            imgData = (self.imgVwUser.image?.jpegData(compressionQuality: 0.2))!
        }
        imageData.append(imgData!)
        
        let imageParam = ["user_image"]
        
        let dicrParam = [
            "user_id":objAppShareData.UserDetail.strUserId ?? "",
            "name":self.tfName.text!,
            "email":self.tfEmail.text!,
            "mobile":self.tfMobile.text!,
            "address":self.tfAddress.text!,
            "country":self.tfCountry.text!,
            "state":self.tfState.text!,
            "city":self.tfCity.text!,
            "zip_code":self.tfPin.text!,
            "service_rate":self.tfRate.text!,
            "language":objAppShareData.currentLanguage]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.uploadMultipartWithImagesData(strURL: WsUrl.url_update_profile, params: dicrParam, showIndicator: true, customValidation: "", imageData: imgData, imageToUpload: imageData, imagesParam: imageParam, fileName: "user_image", mimeType: "image/jpeg") { (response) in
            objWebServiceManager.hideIndicator()
            print(response)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            if status == MessageConstant.k_StatusCode{
                
                
                guard let user_details  = response["result"] as? [String:Any] else{
                    return
                }
                
                objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "", message: "Profile Updated Succesfully", controller: self) {
                    self.setRootController()
                }
                
                
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: response["result"] as? String ?? "", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            print(Error)
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
    
}
