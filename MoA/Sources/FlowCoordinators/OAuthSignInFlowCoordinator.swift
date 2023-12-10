//
//  OAuthSignInFlowCoordinator.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import UIKit

class OAuthSignInFlowCoordinator: FlowCoordinator {
    fileprivate let window: UIWindow
    fileprivate var oauthSignInNavigationController: UINavigationController?
    fileprivate let dependencyProvider: OAuthSignInFlowCoordinatorDependencyProvider
    
    init(window: UIWindow, dependencyProvider: OAuthSignInFlowCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let oauthSignInNavigationController = dependencyProvider.oauthSignInNavigationController(navigator: self)
        window.rootViewController = oauthSignInNavigationController
        self.oauthSignInNavigationController = oauthSignInNavigationController
    }
}

extension OAuthSignInFlowCoordinator: OAuthSignInNavigator {
    func signIn(forSignIn accessToken: String) {
        let page = self.dependencyProvider.signInController(accessToken)
        oauthSignInNavigationController?.pushViewController(page, animated: true)
    }
}
