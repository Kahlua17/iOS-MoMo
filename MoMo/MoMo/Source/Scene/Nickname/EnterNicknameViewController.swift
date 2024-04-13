//
//  EnterNicknameViewController.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import SnapKit
import Then
import UIKit

final class EnterNicknameViewController: UIViewController {
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "게으른 베짱이"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.systemIndigo, for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.addAction(
            .init(handler: { [weak self] _ in
                self?.didTapConfirmButton()
            }),
            for: .touchUpInside
        )
        return button
    }()

    private let network = Network(session: .shared)
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

        title = "닉네임을 입력하기 ✏️"

        view.backgroundColor = .white

        view.addSubview(nicknameTextField)
        view.addSubview(confirmButton)
        nicknameTextField.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }

    private func didTapConfirmButton() {
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else {
            let alertController = UIAlertController(title: "⚠️", message: "닉네임을 입력해주세요.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }

        print("입력된 닉네임: \(nickname)")

        Task {
            let response = try await network.send(EnterNicknameRequest(body: .init(nickname: nickname)))
            
            try await localStorage.write(nickname, forKey: .nickname)
            try await localStorage.write(response.userId, forKey: .userId)
            
            let mainTabBarController = MainTabBarController()
            mainTabBarController.modalPresentationStyle = .fullScreen
            self.present(mainTabBarController, animated: false)
        }
    }
}

extension EnterNicknameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
