//
//  SignUpViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    var strType:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    

    @IBAction func btnOnRegister(_ sender: Any) {
        if validateFields() {
                call_Websercice_SignUp()
            }
    }
}

extension SignUpViewController {

    func validateFields() -> Bool {

        // Username
        guard let name = tfUserName.text, !name.isEmpty else {
            objAlert.showAlert(message: "Please enter your name.", title: "Alert", controller: self)
            return false
        }

        // Email
        guard let email = tfEmail.text, !email.isEmpty else {
            objAlert.showAlert(message: "Please enter your email.", title: "Alert", controller: self)
            return false
        }

        if !isValidEmail(email) {
            objAlert.showAlert(message: "Please enter a valid email.", title: "Alert", controller: self)
            return false
        }

        // Mobile
        guard let mobile = tfMobile.text, !mobile.isEmpty else {
            objAlert.showAlert(message: "Please enter mobile number.", title: "Alert", controller: self)
            return false
        }


        // Password
        guard let password = tfPassword.text, !password.isEmpty else {
            objAlert.showAlert(message: "Please enter password.", title: "Alert", controller: self)
            return false
        }


        // Address
        guard let address = tfAddress.text, !address.isEmpty else {
            objAlert.showAlert(message: "Please enter address.", title: "Alert", controller: self)
            return false
        }

        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}


extension SignUpViewController {
    
    func call_Websercice_SignUp() {
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = ["name": self.tfUserName.text!,
            "email": self.tfEmail.text!,
                         "mobile": self.tfMobile.text!,
                         "address": self.tfAddress.text!,
                         "password": self.tfPassword.text!,
                         "device_type": "iOS",
                         "register_id": objAppShareData.strFirebaseToken,
                         "type":self.strType,
                         "language":objAppShareData.currentLanguage]as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.uel_SignUp, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                if let resultArray = response["result"] as? [String: Any] {
                    
                    objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: resultArray)
                    objAppShareData.fetchUserInfoFromAppshareData()
                    
                    if self.strType == UserInfoType.Employee.rawValue{
                        self.setRootController()
                    }else{
                        self.setRootControllerEmployer()
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
    
    func setRootController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        let navController = UINavigationController(rootViewController: homeViewController)
        navController.navigationBar.isHidden = true
        appDelegate.window?.rootViewController = navController
    }
    
    func setRootControllerEmployer() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarEmployerViewController") as! TabBarEmployerViewController
        let navController = UINavigationController(rootViewController: homeViewController)
        navController.navigationBar.isHidden = true
        appDelegate.window?.rootViewController = navController
    }
}
