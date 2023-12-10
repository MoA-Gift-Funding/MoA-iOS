//
//  OAuthSignInViewModel.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import Foundation
import Combine

final class OAuthSignInViewModel: OAuthSignInViewModelType {
    
    private let useCase: UserUseCaseType
    private var cancellables: [AnyCancellable] = []
    
    init(useCase: UserUseCaseType) {
        self.useCase = useCase
    }
    
    func transform(input: OAuthSignInViewModelInput) -> OAuthSignInViewModelOutput {
        input.signIn
            .sink(receiveValue: { [unowned self] accessToken in
//                let viewModel = SignInViewModel(accessToken: accessToken, useCase: self.useCase)
//                let page = SignInViewController(viewModel: viewModel)
//                
//                self.navigationController?.pushViewController(page, animated: true)
            })
            .store(in: &cancellables)
        
        let loading: OAuthSignInViewModelOutput = input.signIn.map({_ in .loading
        }).eraseToAnyPublisher()
        
        return loading
    }
    
    
}
