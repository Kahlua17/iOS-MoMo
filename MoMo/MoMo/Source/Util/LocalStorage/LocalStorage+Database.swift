//
//  LocalStorage+Database.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Foundation

public protocol Database {
    func load(forKey key: String) async throws -> Data?
    func save(_ value: Data, forKey key: String) async throws
    func remove(forKey key: String) async throws
}

public protocol LocalStorage {
    func read<T: Codable>(forKey key: LocalStorageKey, type: T.Type) async throws -> T?
    func write<T: Codable>(_ value: T, forKey key: LocalStorageKey) async throws -> Void
    func delete(forKey key: LocalStorageKey) async throws -> Void
}

public final class LocalStorageImpl: LocalStorage {

    public init(
        database: Database,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.database = database
        self.encoder = encoder
        self.decoder = decoder
    }

    public func read<T: Codable>(forKey key: LocalStorageKey, type: T.Type) async throws -> T? {
        guard let data = try await self.database.load(forKey: key.rawValue) else { return nil }
        return try decoder.decode(T.self, from: data)
    }

    public func write<T: Codable>(_ value: T, forKey key: LocalStorageKey) async throws -> Void {
        let data = try encoder.encode(value)
        try await self.database.save(data, forKey: key.rawValue)
        return Void()
    }

    public func delete(forKey key: LocalStorageKey) async throws -> Void {
        try await self.database.remove(forKey: key.rawValue)
        return Void()
    }

    private let database: Database
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

}
