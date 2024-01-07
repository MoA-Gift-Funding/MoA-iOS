//
//  ApplicationComponentsFactory.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import UIKit

final class ApplicationComponentsFactory {
    fileprivate lazy var useCase: UserUseCaseType = UserUseCase(networkService: servicesProvider.network)
    private let servicesProvider: ServicesProvider
    
    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
    
    func oauthSignInNavigationController(navigator: OAuthSignInNavigator) -> UINavigationController {
        let viewModel = OAuthSignInViewModel(useCase: useCase, navigator: navigator)
        let oauthSignInviewController = OAuthSignInViewController(viewModel: viewModel)
        let oauthSignInNavigationController = UINavigationController(rootViewController: oauthSignInviewController)
        oauthSignInNavigationController.navigationBar.tintColor = .label
        return oauthSignInNavigationController
    }
    
    func signInController(_ accessToken: String) -> UIViewController {
        let viewModel = EnterUserInfoViewModel(accessToken: accessToken, useCase: useCase)
        return EnterUserInfoViewController(viewModel: viewModel)
    }
    
}
