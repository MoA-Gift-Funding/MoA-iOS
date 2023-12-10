//
//  OAuthSignInViewModel.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import Foundation
import Combine

final class OAuthSignInViewModel: OAuthSignInViewModelType {
    
    private weak var navigator: OAuthSignInNavigator?
    private let useCase: UserUseCaseType
    private var cancellables: [AnyCancellable] = []
    
    init(useCase: UserUseCaseType, navigator: OAuthSignInNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: OAuthSignInViewModelInput) -> OAuthSignInViewModelOutput {
        input.signIn
            .sink(receiveValue: { [unowned self] accessToken in
                self.navigator?.signIn(forSignIn: accessToken)
            })
            .store(in: &cancellables)

        let loading: OAuthSignInViewModelOutput = input.signIn.map({_ in .loading
        }).eraseToAnyPublisher()
        
        return loading
    }
    
    
}
