//
//  EditMoimDTO.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Foundation

struct EditMoimRequest: Request {
    typealias Body = EditMoimRequestBody
    typealias Output = EditMoimResponse

    var endpoint: String = "/meeting"
    var method: HTTPMethod = .post

    var body: EditMoimRequestBody?
    init(body: EditMoimRequestBody) {
        self.body = body
    }
}

struct EditMoimRequestBody: RequestBody {
    let dateTime: String
    let locationDesc: String
}

struct EditMoimResponse: Response {
    let id: String
}
