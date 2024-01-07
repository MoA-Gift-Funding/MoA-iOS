//
//  EnterUserInfoViewModelType.swift
//  MoA
//
//  Created by eunae on 2023/11/19.
//

import UIKit
import Combine

// INPUT
struct EnterUserInfoViewModelInput {
    let appear: AnyPublisher<Void, Never>
}

// OUTPUT
enum EnterUserInfoState {
    case loading
    case success(UserViewModel)
    case failure(Error)
}

extension EnterUserInfoState: Equatable {
    static func == (lhs: EnterUserInfoState, rhs: EnterUserInfoState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhsUser), .success(let rhsUser)): return lhsUser == rhsUser
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias EnterUserInfoViewModelOutput = AnyPublisher<EnterUserInfoState, Never>

protocol EnterUserInfoViewModelType: AnyObject {
    func transform(input: EnterUserInfoViewModelInput) -> EnterUserInfoViewModelOutput
}
