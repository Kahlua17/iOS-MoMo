//
//  UserDefaults+Database.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Foundation

extension UserDefaults: Database {
    public func load(forKey key: String) async throws -> Data? {
        self.data(forKey: key)
    }

    public func save(_ value: Data, forKey key: String) async throws {
        self.set(value, forKey: key)
    }


    public func remove(forKey key: String) async throws {
        self.removeObject(forKey: key)
    }
}
