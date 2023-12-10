//
//  UserViewModel.swift
//  MoA
//
//  Created by eunae on 2023/11/19.
//

import Foundation
import UIKit.UIImage
import Combine

struct UserViewModel {
    let accessToken: String
    let email: String
    let nickname: String
    let profileImage: String?
    let birthday: String
    let birthyear: String
    let phoneNumber: String
    let level: String
    
    init(accessToken: String,
        email: String,
        nickname: String,
        profileImage: String?,
        birthday: String,
        birthyear: String,
        phoneNumber: String,
        level: String) {
        self.accessToken = accessToken
        self.email = email
        self.nickname = nickname
        self.profileImage = profileImage
        self.birthday = birthday
        self.birthyear = birthyear
        self.phoneNumber = phoneNumber
        self.level = level
    }
}

extension UserViewModel: Hashable {
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.accessToken == rhs.accessToken
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(accessToken)
    }
}
