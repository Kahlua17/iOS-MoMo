//
//  HomeViewController.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    let navigationBarTitle = UILabel()
    let navigationBarUserButton = UIButton()
    let separatorView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        separatorView.backgroundColor = .black
        
        
        // ===== 네비게이션 바 ===== //
        
        let navigationBar = UIView()
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
         navigationBarTitle.text = "Hello, 이름!"
         navigationBarTitle.font = UIFont.boldSystemFont(ofSize: 18)
         navigationBarTitle.textColor = .black
         navigationBarTitle.textAlignment = .left
         navigationBarTitle.snp.makeConstraints {
             $0.leading.equalToSuperview().offset(16) // 왼쪽 여백 설정
             $0.centerY.equalToSuperview() // 수직 중앙 정렬
         }

         // 네비게이션 바 오른쪽 아이콘 버튼
        navigationBar.addSubview(navigationBarUserButton)
        if let image = UIImage(systemName: "person.circle.fill") {
            navigationBarUserButton.setImage(image, for: .normal)
        }
        
        navigationBarUserButton.addTarget(self, action: #selector(navigationBarUserButtonTapped), for: .touchUpInside)
        
        navigationBarUserButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16) // 오른쪽 여백 설정
            $0.centerY.equalToSuperview() // 수직 중앙 정렬
            $0.width.height.equalTo(30) // 아이콘 크기 설정
        }
        navigationBarUserButton.tintColor = .gray

        
        
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
        
        let contentTodayView = UIView().then {
            $0.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(contentTodayButtonTapped))
            $0.addGestureRecognizer(tapGesture)
        }
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
            $0.height.equalTo(30)
        }
        
        // 날짜 라벨 추가
        let contentTodayDateLabel = UILabel()
        contentTodayDateLabel.text = "2024-04-13"
        contentTodayDateLabel.font = UIFont.systemFont(ofSize: 12)
        contentTodayView.addSubview(contentTodayDateLabel)
        contentTodayDateLabel.snp.makeConstraints {
            $0.leading.equalTo(contentTodayTitleLabel.snp.trailing).offset(5) // 제목 라벨 우측 여백 5
            $0.firstBaseline.equalTo(contentTodayTitleLabel)
            $0.bottom.equalTo(contentTodayTitleLabel.snp.bottom).offset(0) // 하단 여백 제목 라벨과 동일
        }
        
        // 초대 링크
        let inviteLinkLabel = UILabel().then {
            $0.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(inviteLinkLabelTapped))
            $0.addGestureRecognizer(tapGesture)
        }
        inviteLinkLabel.text = "초대 링크 복사"
        inviteLinkLabel.font = UIFont.systemFont(ofSize: 12)
        contentTodayView.addSubview(inviteLinkLabel)
        inviteLinkLabel.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(16)
        }
        
        // 참여자 라벨 추가
        let contentTodayMemberLabel = UILabel()
        contentTodayMemberLabel.text = "참여자"
        contentTodayMemberLabel.font = UIFont.boldSystemFont(ofSize: 15)
        contentTodayView.addSubview(contentTodayMemberLabel)
        contentTodayMemberLabel.snp.makeConstraints {
            $0.top.equalTo(contentTodayTitleLabel.snp.bottom).offset(5) // 제목 라벨 아래로 5만큼 내림
            $0.leading.equalTo(contentTodayTitleLabel) // 제목 라벨과 왼쪽 정렬
        }
        
        // 참여자 값 추가
        let contentTodayMemberValue = UILabel()
        contentTodayMemberValue.text = "| 생성자 외 4명"
        contentTodayMemberValue.font = UIFont.systemFont(ofSize: 15)
        contentTodayView.addSubview(contentTodayMemberValue)
        contentTodayMemberValue.snp.makeConstraints {
            $0.top.equalTo(contentTodayMemberLabel.snp.bottom).offset(5) // 제목 라벨 아래로 5만큼 내림
            $0.leading.equalTo(contentTodayMemberLabel) // 제목 라벨과 왼쪽 정렬
        }
        
        // 장소 라벨 추가
        let contentTodayLocationLabel = UILabel()
        contentTodayLocationLabel.text = "장소"
        contentTodayLocationLabel.font = UIFont.boldSystemFont(ofSize: 15)
        contentTodayView.addSubview(contentTodayLocationLabel)
        contentTodayLocationLabel.snp.makeConstraints {
            $0.top.equalTo(contentTodayTitleLabel.snp.bottom).offset(5) // 제목 라벨 아래로 5만큼 내림
            $0.leading.equalTo(contentTodayView.snp.centerX)
            $0.bottom.equalTo(contentTodayMemberLabel.snp.bottom).offset(0) // 하단 여백 제목 라벨과 동일
        }
        
        // 장소 값 추가
        let contentTodayLocationValue = UILabel()
        contentTodayLocationValue.text = "| 서울특별시 강남구 뭐시기 저시기 어쩌구 저쩌구"
        contentTodayLocationValue.font = UIFont.systemFont(ofSize: 15)
        contentTodayView.addSubview(contentTodayLocationValue)
        contentTodayLocationValue.snp.makeConstraints {
            $0.top.equalTo(contentTodayLocationLabel.snp.bottom).offset(5) // 제목 라벨 아래로 5만큼 내림
            $0.leading.equalTo(contentTodayLocationLabel) // 제목 라벨과 왼쪽 정렬
            $0.right.equalToSuperview().inset(16)
        }
        
        // 정산 금액 라벨 추가
        let contentTodayBudgetLabel = UILabel()
        contentTodayBudgetLabel.text = "50,000원"
        contentTodayBudgetLabel.font = UIFont.systemFont(ofSize: 15)
        contentTodayView.addSubview(contentTodayBudgetLabel)
        contentTodayBudgetLabel.snp.makeConstraints {
            $0.top.equalTo(contentTodayMemberValue.snp.bottom).offset(5) // 참여자 값 아래로 5만큼 내림
            $0.leading.equalTo(contentTodayTitleLabel) // 제목 라벨과 왼쪽 정렬
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        
        // 구분선
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.top.equalTo(contentTodayView.snp.bottom).offset(16) // contentTodayView 아래 5만큼
            $0.leading.trailing.equalTo(contentTodayView) // contentTodayView와 같은 위치
            $0.height.equalTo(1) // 실선의 높이
        }
    }
    
    @objc func navigationBarUserButtonTapped() {
        print("네비게이션 바 오른쪽 아이콘 탭")
    }
    
    @objc func contentTodayButtonTapped() {
        print("오늘의 모임 버튼 탭")
        let detailViewController = DetailViewController()
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc func inviteLinkLabelTapped() {
        print("초대 링크 복사 탭")
    }
}
