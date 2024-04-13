//
//  MoimDetailCheckoutCell.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import UIKit

struct MoimDetailCheckoutViewModel {
    let date: String
    let money: Int
    let payer: String
    let participantes: [String]
}

final class MoimDetailCheckoutCell: UICollectionViewCell {
    static let identifier = "MoimDetailCell"

    private let dateLabel = UILabel()
    private let payerLabel = UILabel()
    private let moneyLabel = UILabel()
    private let participantLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 8
        dateLabel.font = .systemFont(ofSize: 12)
        payerLabel.font = .systemFont(ofSize: 12)
        moneyLabel.font = .boldSystemFont(ofSize: 18)
        participantLabel.font = .systemFont(ofSize: 12)

        dateLabel.text = "2024-04-13(토)"
        payerLabel.text = "이재용"
        moneyLabel.text = "27,000원"
        participantLabel.text = "로운 외 2명"

        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
        }
        addSubview(payerLabel)
        payerLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.leading.equalTo(dateLabel)
        }
        addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(payerLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateLabel)
        }
        addSubview(participantLabel)
        participantLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(moneyLabel)
        }
    }
}
