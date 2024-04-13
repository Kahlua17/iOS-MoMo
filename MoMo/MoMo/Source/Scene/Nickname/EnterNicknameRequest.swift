//
//  EnterNicknameRequest.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Foundation

struct EnterNicknameRequest: Request {
    typealias Body = EnterNicknameRequestBody
    typealias Output = EnterNicknameResponse

    var endpoint: String = "/nickname"
    var method: HTTPMethod = .post

    var header: HTTPHeader {
        ["UUID": "\(UUID().uuidString)"]
    }
    var body: EnterNicknameRequestBody?
    init(body: EnterNicknameRequestBody) {
        self.body = body
    }
}

struct EnterNicknameRequestBody: RequestBody {
    let nickname: String
}

struct EnterNicknameResponse: Response {
    let message: String
    let userId: String
}
