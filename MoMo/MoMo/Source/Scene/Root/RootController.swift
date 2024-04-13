//
//  RootController.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Then
import UIKit

final class RootController: UIViewController {
    private let localStorage: any LocalStorage

    init(localStorage: any LocalStorage) {
        self.localStorage = localStorage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        didSetup()
    }
}

extension RootController {
    private func didSetup() {
        Task {
            let userId = try await localStorage.read(forKey: .userId, type: UserId.self)

//            if let userId {
                let mainTabBarController = MainTabBarController()
                mainTabBarController.modalPresentationStyle = .fullScreen
                self.switchToViewController(mainTabBarController)
//            } else {
//                let enterNicknameViewController = UINavigationController(
//                    rootViewController: EnterNicknameViewController()
//                ).then {
//                    $0.navigationBar.prefersLargeTitles = true
//                }
//                enterNicknameViewController.modalPresentationStyle = .fullScreen
//                self.switchToViewController(enterNicknameViewController)
//            }
        }
    }

    private func switchToViewController(
        _ viewController: UIViewController,
        completion: (() -> Void)? = nil
    ) {
        self.present(viewController, animated: false, completion: completion)
    }
}
