//
//  EditMoimViewController.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import SnapKit
import Then
import UIKit

final class EditMoimViewController: UIViewController {
    private let moimTitleLabel = UILabel().then {
        $0.text = "모임 장소를 입력해주세요"
        $0.font = .systemFont(ofSize: Const.titleLabelSize, weight: .medium)
    }

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "허슬버슬~"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()

    private let moimCalendarTitleLabel = UILabel().then {
        $0.text = "모임 날짜를 선택해주세요"
        $0.font = .systemFont(ofSize: Const.titleLabelSize, weight: .medium)
    }
    
    private let moimCalendarView = UICalendarView()
  
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

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.red, for: .normal)
        closeButton.addAction(
            .init(handler: { [weak self] _ in self?.dismiss(animated: true) }),
            for: .touchUpInside
        )

        navigationItem.rightBarButtonItem = .init(customView: closeButton)

        view.backgroundColor = .white

        title = "모임 생성하기 ✏️"

        let containerView = UIView()

        view.addSubview(containerView)
        containerView.addSubview(moimTitleLabel)
        containerView.addSubview(titleTextField)
        containerView.addSubview(moimCalendarTitleLabel)
        containerView.addSubview(moimCalendarView)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        moimTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(moimTitleLabel.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        moimCalendarTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        moimCalendarView.snp.makeConstraints { make in
            make.top.equalTo(moimCalendarTitleLabel.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }

    @objc private func didTapConfirmButton() {
        self.dismiss(animated: true)
    }
}

extension EditMoimViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension EditMoimViewController {
    private enum Const {
        static let titleLabelSize: CGFloat = 16
    }
}
