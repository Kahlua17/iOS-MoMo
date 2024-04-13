//
//  String+.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Foundation

public typealias UserId = String

extension String {
    public static let empty = ""
    public var isNotEmpty: Bool { !isEmpty }
}
