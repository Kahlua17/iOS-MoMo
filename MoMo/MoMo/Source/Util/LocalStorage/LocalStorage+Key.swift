//
//  LocalStorage+Key.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Foundation

public struct LocalStorageKey: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension LocalStorageKey {
    static let userId = LocalStorageKey(rawValue: "com.kahlua.MoMo.userId")
}
