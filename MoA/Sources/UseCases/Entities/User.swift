//
//  User.swift
//  MoA
//
//  Created by eunae on 2023/11/14.
//

import Foundation


struct UserResponse {
    let status: String
    let message: String?
    let data: User
}

extension UserResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
}

struct User {
    let accessToken: String
    let email: String?
    let nickname: String?
    let profileImage: String?
    let birthday: String?
    let birthyear: String?
    let phoneNumber: String?
    let level: String?
}

extension User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.accessToken == rhs.accessToken
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(accessToken)
    }
}

extension User: Decodable {
    enum CodingKeys: String, CodingKey {
        case accessToken
        case email
        case nickname
        case profileImage
        case birthday
        case birthyear
        case phoneNumber
        case level
    }
}
