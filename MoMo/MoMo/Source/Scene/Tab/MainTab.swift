//
//  MainTab.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import UIKit

enum MainTab: Int, CaseIterable, Equatable {
    case home
    case calendar
}

extension MainTab {
    var title: String {
        switch self {
        case .home: return "세미나"
        case .calendar: return "마이페이지"
        }
    }

    var activeIcon: UIImage? {
        switch self {
        case .home: return nil
        case .calendar: return nil
        }
    }

    var icon: UIImage? {
        switch self {
        case .home: return nil
        case .calendar: return nil
        }
    }
}

extension MainTab {
    func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: self.title,
            image: self.icon,
            selectedImage: self.activeIcon
        )
    }
}
