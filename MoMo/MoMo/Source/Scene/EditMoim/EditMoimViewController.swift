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
    
    private lazy var moimCalendarView = UICalendarView().then {
        $0.calendar = .current
        $0.locale = .current
        $0.fontDesign = . rounded
        $0.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
    }

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

    private var moimTitle: String?
    private var moimDateString: String?

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
        containerView.addSubview(confirmButton)

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
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(moimCalendarView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
    }

    @objc private func didTapConfirmButton() {
        guard let moimTitle,
              let moimDateString
        else {
            let alertController = UIAlertController(title: "⚠️", message: "빠진 값이 있어요", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }

        Task {
            let response = try await network.send(
                EditMoimRequest(body: .init(
                    dateTime: moimDateString,
                    locationDesc: moimTitle
                ))
            )
            self.dismiss(animated: true)
        }

    }
}

extension EditMoimViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        moimTitle = textField.text
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moimTitle = textField.text
        view.endEditing(true)
        return true
    }
}

extension EditMoimViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didSelectDate dateComponents: DateComponents?
    ) {
        if let date = dateComponents?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            moimDateString = dateFormatter.string(from: date)
            print(moimDateString)
        }
    }
}

extension EditMoimViewController {
    private enum Const {
        static let titleLabelSize: CGFloat = 16
    }
}

