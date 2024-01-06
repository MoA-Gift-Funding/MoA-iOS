//
//  SignInViewModel.swift
//  MoA
//
//  Created by eunae on 2023/11/19.
//

import UIKit
import Combine

class SignInViewModel: SignInViewModelType {
    
    private let accessToken: String
    private let useCase: UserUseCaseType
    
    
    init(accessToken: String, useCase: UserUseCaseType) {
        self.accessToken = accessToken
        self.useCase = useCase
    }
    
    func transform(input: SignInViewModelInput) -> SignInViewModelOutput {
        let signIn = input.appear
            .flatMap({[unowned self] _ in
                self.useCase.signIn(with: self.accessToken)
            })
            .map({ result -> SignInState in
                switch result {
                    case .success(let user): return .success(self.viewModel(from: user))
                    case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()
        let loading: SignInViewModelOutput = input.appear.map({_ in .loading}).eraseToAnyPublisher()
        
        return Publishers.Merge(loading, signIn).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func viewModel(from user: User) -> UserViewModel {
        return UserViewModelBuilder.viewModel(from: user)
    }
}
