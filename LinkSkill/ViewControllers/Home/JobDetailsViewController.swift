//
//  JobDetailsViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 04/10/25.
//

import UIKit
import SDWebImage

class JobDetailsViewController: UIViewController {
    
    @IBOutlet weak var lblHeadertitle: UILabel!
    @IBOutlet weak var lblServicetypetitle: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var lblEuro: UILabel!
    @IBOutlet weak var lblDescriptionServiceTitle: UILabel!
    @IBOutlet weak var lblDescriptionService: UILabel!
    @IBOutlet weak var lblDescriptionServiceHeading: UILabel!
    @IBOutlet weak var lblApplyNow: UILabel!
    @IBOutlet weak var btnOnApplyNow: UIButton!
    @IBOutlet weak var tblVwDescreiptionServices: UITableView!
    @IBOutlet weak var vwAwardedEmployee: UIView!
    @IBOutlet weak var vwAwardedEmployeer: UIView!
    @IBOutlet weak var tblVwhgtConstant: NSLayoutConstraint!
    @IBOutlet weak var vwApplyForJob: UIView!
    @IBOutlet weak var lblAwardedEmployeeTitle: UILabel!
    @IBOutlet weak var lblEmployeeAwardedName: UILabel!
    
    @IBOutlet weak var imgVwAwardedEmployee: UIImageView!
    
    @IBOutlet weak var lblNameEmployerAwardedName: UILabel!
    @IBOutlet weak var lblEmployerAwardedTitle: UILabel!
    @IBOutlet weak var imgVwAwardedEmployer: UIImageView!
    
    var isComingFrom = ""
    var objJobDetails: JobsModel?
    var arrServices = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpUI()
    }
    
    func setUpUI(){
        self.lblHeadertitle.applyStyle(AppFonts.title)
        self.lblServicetypetitle.applyStyle(AppFonts.title_regular)
        self.lblDescriptionServiceTitle.applyStyle(AppFonts.title_regular)
        self.lblDescriptionServiceHeading.applyStyle(AppFonts.title_regular)
        self.lblApplyNow.applyStyle(AppFonts.subtitle)
        self.lblServiceType.applyStyle(AppFonts.subtitle_regular_12)
        self.lblDescriptionService.applyStyle(AppFonts.subtitle_regular_12)
        self.btnOnApplyNow.applyStyle(AppFonts.title_regular)
        self.lblEuro.applyStyle(AppFonts.price18)
        
        if self.isComingFrom == "Employee"{
            self.vwAwardedEmployee.isHidden = true
            self.vwAwardedEmployeer.isHidden = true
            
            self.lblServiceType.text = "\(self.objJobDetails?.type ?? "")"
            self.lblDescriptionService.text = "\(self.objJobDetails?.details ?? "")"
            let symbol = (objJobDetails?.currency?.uppercased() == "USD") ? "$" : "€"
            self.lblEuro.text = "\(symbol)\(objJobDetails?.price?.formattedPrice ?? "") \(objJobDetails?.currency ?? "")"
            
            if let categories = self.objJobDetails?.categoryName {
                let categoryArray = categories
                    .components(separatedBy: ",")        // Split by comma
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } // Remove extra spaces
                self.arrServices.append(contentsOf: categoryArray)
            }
            
            self.tblVwDescreiptionServices.reloadData()
            self.updateTableHeight()
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            if let status = objJobDetails?.status,
               (status == "Accepted" || status == "Completed"),
               let employeeName = objJobDetails?.employeeName,
               !employeeName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.vwAwardedEmployee.isHidden = false
                self.lblEmployeeAwardedName.text = employeeName
                if let imageUrlString = objJobDetails?.employeeImage,
                   !imageUrlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   let imageUrl = URL(string: imageUrlString) {
                    self.imgVwAwardedEmployee.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
                } else {
                    self.imgVwAwardedEmployee.image = UIImage(named: "placeholder")
                }
            } else {
                self.vwAwardedEmployee.isHidden = true
            }
            
            if objJobDetails?.isBided == 1{
                self.vwApplyForJob.isHidden = true
            }else{
                self.vwApplyForJob.isHidden = false
            }
        }else{
            self.vwApplyForJob.isHidden = true
            
        }
    }
    
    private func setupTableView() {
        // Register nib
        let nib = UINib(nibName: "JobDetailDescriptionServicesTableViewCell", bundle: nil)
        tblVwDescreiptionServices.register(nib, forCellReuseIdentifier: "JobDetailDescriptionServicesTableViewCell")
        // Set delegates
        tblVwDescreiptionServices.delegate = self
        tblVwDescreiptionServices.dataSource = self
    }
    
    
    @IBAction func btnOnback(_ sender: Any) {
        self.onBackPressed()
    }
    
    
    @IBAction func btnApplyNow(_ sender: Any) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ApplyForJobViewController") as! ApplyForJobViewController
        vc.objJobDetails = self.objJobDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnOnWhatIsMilestone(_ sender: Any) {
        
    }
    
    @IBAction func btnOnCreateMilestone(_ sender: Any) {
        
    }
    
    @IBAction func btnOnMarkAsComplete(_ sender: Any) {
        
    }
}


extension JobDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailDescriptionServicesTableViewCell") as? JobDetailDescriptionServicesTableViewCell {
            
            cell.lbltitle.text = arrServices[indexPath.row]
            
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    private func updateTableHeight() {
        tblVwDescreiptionServices.layoutIfNeeded() // Ensure layout is updated
        let rowHeight: CGFloat = 40 // or your estimated/fixed row height
        tblVwhgtConstant.constant = rowHeight * CGFloat(arrServices.count)
    }
    
}
