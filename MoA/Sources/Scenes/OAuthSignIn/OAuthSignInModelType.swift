//
//  OAuthSignInModelType.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import Foundation
import Combine

// INPUT
struct OAuthSignInViewModelInput {
    let signIn: AnyPublisher<String, Never>
}

// OUTPUT
enum OAuthSignInState {
    case loading
    case success
    case failure(Error)
}

extension OAuthSignInState: Equatable {
    static func == (lhs: OAuthSignInState, rhs: OAuthSignInState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success, .success): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias OAuthSignInViewModelOutput = AnyPublisher<OAuthSignInState, Never>

protocol OAuthSignInViewModelType: AnyObject {
    func transform(input: OAuthSignInViewModelInput) -> OAuthSignInViewModelOutput
}
