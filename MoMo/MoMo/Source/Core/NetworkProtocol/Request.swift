//
//  Request.swift
//  Core
//
//  Created by Gunoo on 2022/07/03.
//  Copyright © 2022 kr.mash-up. All rights reserved.
//

import Foundation

/// Restful api Method
public enum HTTPMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Query Params Array
public typealias QueryItems = [String: AnyHashable]

/// Http Header
/// ex) "Content-Type": "multipart/form-data"
public typealias HTTPHeader = [String: String]

/// Post Request Body
public protocol RequestBody: Encodable {}

/// RequestBody가 없는 통신 일 경우 사용
///
/// ex)
/// ```swift
/// struct LoginRequest: Request {
///   typealias Body = EmptyRequestBody
///   typealias Output = LoginResponse
///
///   var endpoint: String = "/login"
///
///   var method: HTTPMethod = .post
/// }
/// ```
public struct EmptyRequestBody: RequestBody {}

/// Restful api Request
public protocol Request {
    /// Request Body
    associatedtype Body: RequestBody
    /// Response
    associatedtype Output: Response
    
    /// path
    var endpoint: String { get }
    /// restful api method
    var method: HTTPMethod { get }
    /// query params
    /// default [:]
    var query: QueryItems { get }
    /// http header
    /// default [:]
    var header: HTTPHeader { get }
    /// Content-Type in header
    /// default "application/json"
    var contentType: String { get }
    /// post body
    /// default nil
    var body: Body? { get }
}

public extension Request {
    var query: QueryItems {
        return [:]
    }

    var header: HTTPHeader {
        return ["User-ID": "\(userId)"]
    }
    
    var contentType: String {
        return "application/json"
    }
    
    private var userId: String {
        guard let userId = UserDefaults.standard.string(
            forKey: LocalStorageKey.userId.rawValue
        ) else { return "" }
        return userId
    }
    
    var body: Body? {
        return nil
    }
}

public extension Request {
    var baseURL: String { "\(Const.baseURL)" }
}
