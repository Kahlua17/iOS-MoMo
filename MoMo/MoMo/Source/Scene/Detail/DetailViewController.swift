//
//  DetailViewController.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import SnapKit
import Then
import UIKit

final class DetailViewController: UIViewController {
    private let navigationBar = UIView()
    private let navigationBarTitle = UILabel()
    private let separatorView = UIView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: screenWidth - 32, height: 90)
        layout.minimumLineSpacing = 12
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.dataSource = self
        v.delaysContentTouches = false
        v.register(MoimDetailCheckoutCell.self, forCellWithReuseIdentifier: MoimDetailCheckoutCell.identifier)
        v.contentInset.bottom = 60
        return v
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("비용 추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.systemIndigo, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addAction(
            .init(handler: { [weak self] _ in
                print("### 비용 추가하기")
            }),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var requestPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("정산 요청하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.systemIndigo, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addAction(
            .init(handler: { [weak self] _ in
                print("### 정산 요청하기")
            }),
            for: .touchUpInside
        )
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.isHidden = true
    }
}

extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .white

        setupNavigationBar()
        setupMoimDetailView()
        setupCollectionView()
        setupButtons()
    }

    private func setupNavigationBar() {
        view.addSubview(navigationBar)

        // 네비게이션 바 제약 조건 설정
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(44) // 기본 네비게이션 바 높이
        }

        // 네비게이션 바 제목
        navigationBar.addSubview(navigationBarTitle)
        navigationBarTitle.text = "Checkout"
        navigationBarTitle.font = UIFont.boldSystemFont(ofSize: 18)
        navigationBarTitle.textColor = .black
        navigationBarTitle.textAlignment = .left
        navigationBarTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16) // 왼쪽 여백 설정
            $0.centerY.equalToSuperview() // 수직 중앙 정렬
        }
    }

    private func setupMoimDetailView() {
        // ===== 컨텐츠 ===== //

        let contentView = UIView()
        contentView.backgroundColor = .white
        view.addSubview(contentView)

        // 컨텐츠 제약 조건 설정
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        // ==== 오늘의 모임 ===== //

        let contentTodayView = UIView()
        contentView.addSubview(contentTodayView)
        contentTodayView.backgroundColor = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1) // F8F9FA
        contentTodayView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16) // contentView의 상단에서 16의 여백
            $0.horizontalEdges.equalToSuperview().inset(16) // 내부 여백
        }

        // 제목 라벨 추가
        let contentTodayTitleLabel = UILabel()
        contentTodayTitleLabel.text = "오늘의 모임"
        contentTodayTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentTodayView.addSubview(contentTodayTitleLabel)
        contentTodayTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

        // 부연설명 라벨 추가
        let contentTodayDescriptionLabel = UILabel()
        contentTodayDescriptionLabel.text = "2024-04-13"
        contentTodayDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        contentTodayView.addSubview(contentTodayDescriptionLabel)
        contentTodayDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(contentTodayTitleLabel.snp.trailing).offset(5) // 제목 라벨 우측 여백 5
            $0.firstBaseline.equalTo(contentTodayTitleLabel)
            $0.bottom.equalTo(contentTodayTitleLabel.snp.bottom).offset(0) // 하단 여백 제목 라벨과 동일
        }

        // 정산 금액 라벨 추가
        let contentTodayBudgetLabel = UILabel()
        contentTodayBudgetLabel.text = "50,000원"
        contentTodayBudgetLabel.font = UIFont.systemFont(ofSize: 15)
        contentTodayView.addSubview(contentTodayBudgetLabel)
        contentTodayBudgetLabel.snp.makeConstraints {
            $0.top.equalTo(contentTodayTitleLabel.snp.bottom).offset(5) // 제목 라벨 아래로 5만큼 내림
            $0.leading.equalTo(contentTodayTitleLabel) // 제목 라벨과 왼쪽 정렬
            $0.height.equalTo(20) // 높이 20
            $0.bottom.equalToSuperview().inset(16)
        }

        // 모임 인원 수 추가
        let contentTodayUserLabel = UILabel()
        contentTodayUserLabel.text = "생성자 외 4명"
        contentTodayUserLabel.font = UIFont.systemFont(ofSize: 12)
        contentTodayView.addSubview(contentTodayUserLabel)
        contentTodayUserLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.firstBaseline.equalTo(contentTodayBudgetLabel)
            $0.bottom.equalTo(contentTodayBudgetLabel.snp.bottom).offset(0) // 하단 여백 제목 라벨과 동일
        }

        // 구분선
        separatorView.backgroundColor = .black
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.top.equalTo(contentTodayView.snp.bottom).offset(16) // contentTodayView 아래 5만큼
            $0.leading.trailing.equalTo(contentTodayView) // contentTodayView와 같은 위치
            $0.height.equalTo(1) // 실선의 높이
        }
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(6)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupButtons() {
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fillEqually
            $0.spacing = 16
        }
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(requestPayButton)

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        requestPayButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        addButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoimDetailCheckoutCell.identifier,
            for: indexPath
        ) as? MoimDetailCheckoutCell
        else { return .init() }

        return cell
    }
}
