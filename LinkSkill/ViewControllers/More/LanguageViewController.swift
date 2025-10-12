//
//  LanguageViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit

class LanguageViewController: UIViewController {
    
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var lblPortuese: UILabel!
    @IBOutlet weak var lblSpanish: UILabel!
    @IBOutlet weak var imgVwSelectEnglish: UIImageView!
    @IBOutlet weak var imgvwPortueseSelect: UIImageView!
    @IBOutlet weak var imgVwSpanishSelect: UIImageView!
    
    // Track selected language code
    var selectedLanguage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide all tick images initially
        hideAllTicks()
        loadCurrentLanguage()
    }
    
    
    // MARK: - Helper Methods
    
    private func hideAllTicks() {
        imgVwSelectEnglish.isHidden = true
        imgvwPortueseSelect.isHidden = true
        imgVwSpanishSelect.isHidden = true
    }
    
    private func loadCurrentLanguage() {
        selectedLanguage = objAppShareData.currentLanguage
        updateTickForSelectedLanguage()
    }
    
    private func updateTickForSelectedLanguage() {
        hideAllTicks()
        switch selectedLanguage {
        case "en":
            imgVwSelectEnglish.isHidden = false
        case "pt":
            imgvwPortueseSelect.isHidden = false
        case "es":
            imgVwSpanishSelect.isHidden = false
        default:
            break
        }
    }
    
    // MARK: - Language Selection
    @IBAction func btnOnBack(_ sender: Any) {
        self.onBackPressed()
    }
    
    
    @IBAction func btnLanguageSelect(_ sender: UIButton) {
        
        var newLanguage: String?
        
        switch sender.tag {
        case 0: newLanguage = "en"
        case 1: newLanguage = "pt"
        case 2: newLanguage = "es"
        default: break
        }
        
        guard let lang = newLanguage, lang != selectedLanguage else { return }
        
        // Show confirmation alert
        let alert = UIAlertController(
            title: "Change Language",
            message: "Do you want to change the language? The app may restart to apply changes.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            self?.changeLanguage(to: lang)
        }))
        
        present(alert, animated: true)
    }
    private func changeLanguage(to lang: String) {
        // Update shared language
        objAppShareData.currentLanguage = lang
        selectedLanguage = lang
        
        // Update tick UI
        updateTickForSelectedLanguage()
        
        // Restart app after short delay to apply changes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.restartApp()
        }
    }
    
    private func restartApp() {
        // Get the active window scene
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            window.rootViewController = storyboard.instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }

}
