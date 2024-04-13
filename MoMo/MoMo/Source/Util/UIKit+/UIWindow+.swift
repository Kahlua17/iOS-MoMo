//
//  UIWindow+.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import UIKit

extension UIWindow {
    public static var current: UIWindow? {
        UIApplication.shared.windows.first(where: \.isKeyWindow)
    }
}
