//
//  LanguageViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 11/10/25.
//

import UIKit

class LanguageViewController: UIViewController {
    
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblPortuese: UILabel!
    @IBOutlet weak var lblSpanish: UILabel!
    @IBOutlet weak var imgVwSelectEnglish: UIImageView!
    @IBOutlet weak var imgvwPortueseSelect: UIImageView!
    @IBOutlet weak var imgVwSpanishSelect: UIImageView!
    
    // MARK: - Variables

      var selectedLanguage: String?

      // MARK: - Lifecycle

      override func viewDidLoad() {
          super.viewDidLoad()

          setupLocalization()
          hideAllTicks()
          loadCurrentLanguage()
      }

      // MARK: - Localization

      private func setupLocalization() {
          self.lblHeader.text = L10n.language
          lblEnglish.text = L10n.english
          lblSpanish.text = L10n.spanish
          lblPortuese.text = L10n.portuguese
      }

      // MARK: - Tick Handling

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

          case "pt-PT":
              imgvwPortueseSelect.isHidden = false

          case "es":
              imgVwSpanishSelect.isHidden = false

          default:
              break
          }
      }

      // MARK: - Actions

      @IBAction func btnOnBack(_ sender: Any) {
          self.onBackPressed()
      }

      @IBAction func btnLanguageSelect(_ sender: UIButton) {

          var newLanguage: String?

          switch sender.tag {

          case 0:
              newLanguage = "en"

          case 1:
              newLanguage = "pt-PT"

          case 2:
              newLanguage = "es"

          default:
              break
          }

          guard let lang = newLanguage,
                lang != selectedLanguage else {
              return
          }

          let alert = UIAlertController(
              title: "Change Language",
              message: "Do you want to change the language?",
              preferredStyle: .alert
          )

          alert.addAction(UIAlertAction(title: "Cancel",
                                        style: .cancel))

          alert.addAction(UIAlertAction(title: "Yes",
                                        style: .default,
                                        handler: { [weak self] _ in

              self?.changeLanguage(to: lang)
          }))

          present(alert, animated: true)
      }

      // MARK: - Language Change

    private func changeLanguage(to lang: String) {
        print(lang)

        // Save language
        objAppShareData.currentLanguage = lang

        // Update bundle
        Bundle.setLanguage(lang)

        // Update selection UI
        selectedLanguage = lang
        updateTickForSelectedLanguage()

        // Show restart message
        let alert = UIAlertController(
            title: "Restart Required",
            message: "Please restart the app to apply the selected language.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in

            // Close app
            exit(0)
        }))

        self.present(alert, animated: true)
    }

      // MARK: - Restart App

      private func restartApp() {

          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first else {
              return
          }

          // Create completely fresh storyboard
          let storyboard = UIStoryboard(name: "Main", bundle: nil)

          guard let rootVC = storyboard.instantiateInitialViewController() else {
              return
          }

          // Remove old hierarchy
          window.rootViewController = nil

          // Set new root controller
          window.rootViewController = rootVC

          window.makeKeyAndVisible()

          // Smooth transition
          UIView.transition(with: window,
                            duration: 0.25,
                            options: .transitionCrossDissolve,
                            animations: nil)
      }
  }
