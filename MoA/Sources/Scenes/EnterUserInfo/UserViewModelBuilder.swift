//
//  UserViewModelBuilder.swift
//  MoA
//
//  Created by eunae on 2023/11/19.
//

import Foundation
import UIKit.UIImage
import Combine

struct UserViewModelBuilder {
    static func viewModel(from user: User) -> UserViewModel {
        return UserViewModel(accessToken: user.accessToken,
                             email: user.email,
                             nickname: user.nickname,
                             profileImage: user.profileImage,
                             birthday: user.birthday,
                             birthyear: user.birthyear,
                             phoneNumber: user.phoneNumber,
                             level: user.level)
    }
}

extension User {
    
}
