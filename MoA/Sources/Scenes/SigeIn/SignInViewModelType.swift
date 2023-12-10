//
//  SignInViewModelType.swift
//  MoA
//
//  Created by eunae on 2023/11/19.
//

import UIKit
import Combine

// INPUT
struct SignInViewModelInput {
    let appear: AnyPublisher<Void, Never>
}

// OUTPUT
enum SignInState {
    case loading
    case success(UserViewModel)
    case failure(Error)
}

extension SignInState: Equatable {
    static func == (lhs: SignInState, rhs: SignInState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhsUser), .success(let rhsUser)): return lhsUser == rhsUser
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias SignInViewModelOutput = AnyPublisher<SignInState, Never>

protocol SignInViewModelType: AnyObject {
    func transform(input: SignInViewModelInput) -> SignInViewModelOutput
}
