//
//  MainTabBarController.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Then
import SnapKit
import UIKit

final class MainTabBarController: UITabBarController {
    private let tabMenus: [MainTab] = [.home, .calendar]

    private let qrButton = UIButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, HomeTabBar.self)
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        self.qrButton.do {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 24
            $0.setImage(UIImage(systemName: "plus")?.resized(side: 24).withTintColor(.white), for: .normal)
        }
        self.tabBar.addSubview(self.qrButton)
        self.qrButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.tabBar).inset(10)
            $0.size.equalTo(48)
        }
    }

    final class HomeTabBar: UITabBar {
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 68 + safeAreaBottomPadding
            return sizeThatFits
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
