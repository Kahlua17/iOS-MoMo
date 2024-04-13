//
//  MainTabBarController.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Then
import UIKit

final class MainTabBarController: UITabBarController {
    private let tabMenus: [MainTab] = [.home, .calendar]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        self.viewControllers = self.viewControllers(of: tabMenus)
        self.tabBar.do {
            $0.tintColor = .black
            $0.backgroundColor = .white
            $0.itemSpacing = 120
            $0.itemPositioning = .centered
        }
    }
}

extension MainTabBarController {
    private func viewControllers(of tabItems: [MainTab]) -> [UIViewController] {
        return tabItems.map { tab in
            let viewController: UIViewController
            switch tab {
            case .home:
                viewController = UINavigationController(
                    rootViewController: HomeViewController()
                ).then {
                    $0.navigationBar.isHidden = true
                }
            case .calendar:
                viewController = UINavigationController(
                    rootViewController: HomeViewController()
                ).then {
                    $0.navigationBar.isHidden = true
                }
            }
            viewController.tabBarItem = tab.asTabBarItem()
            return viewController
        }
    }
}
