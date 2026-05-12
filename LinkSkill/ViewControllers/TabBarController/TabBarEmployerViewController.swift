//
//  TabBarEmployerViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 15/10/25.
//

import UIKit

class TabBarEmployerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    // MARK: - Setup Tab Bar

    private func setupTabBar() {

        tabBar.tintColor = UIColor.systemYellow
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.backgroundColor = .white

        guard let items = tabBar.items,
              items.count >= 5 else {
            return
        }

        // MARK: - Home

        items[0].title = L10n.home
        items[0].image = UIImage(systemName: "house")
        items[0].selectedImage = UIImage(systemName: "house.fill")

        // MARK: - Chat

        items[1].title = L10n.chat
        items[1].image = UIImage(systemName: "message")
        items[1].selectedImage = UIImage(systemName: "message.fill")

        // MARK: - Plus

        items[2].title = ""
        items[2].image = UIImage(systemName: "plus.circle")
        items[2].selectedImage = UIImage(systemName: "plus.circle.fill")

        // MARK: - Profile

        items[3].title = L10n.profile
        items[3].image = UIImage(systemName: "person")
        items[3].selectedImage = UIImage(systemName: "person.fill")

        // MARK: - More

        items[4].title = L10n.more
        items[4].image = UIImage(systemName: "ellipsis.circle")
        items[4].selectedImage = UIImage(systemName: "ellipsis.circle.fill")
    }
}
