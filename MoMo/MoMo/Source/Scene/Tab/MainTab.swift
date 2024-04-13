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
    var title: String? {
        switch self {
        case .home: return nil
        case .calendar: return nil
        }
    }

    var activeIcon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")?.withTintColor(.black)
        case .calendar: return UIImage(systemName: "calendar")?.withTintColor(.black)
        }
    }

    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")?.withTintColor(.black)
        case .calendar: return UIImage(systemName: "calendar")?.withTintColor(.black)
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
