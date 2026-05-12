//
//  TabBarViewController.swift
//  LinkSkill
//
//  Created by Rohit Singh Dhakad  [C] on 03/10/25.
//

import UIKit

class TabBarViewController: UITabBarController {

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

        // MARK: - Profile
        items[2].title = L10n.profile
        items[2].image = UIImage(systemName: "person")
        items[2].selectedImage = UIImage(systemName: "person.fill")

        // MARK: - More

        items[3].title = L10n.more
        items[3].image = UIImage(systemName: "ellipsis.circle")
        items[3].selectedImage = UIImage(systemName: "ellipsis.circle.fill")
    }
}
