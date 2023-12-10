//
//  ApplicationFlowCoordinatorDependencyProvider.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import UIKit

protocol ApplicationFlowCoordinatorDependencyProvider: OAuthSignInFlowCoordinatorDependencyProvider {}

protocol OAuthSignInFlowCoordinatorDependencyProvider: AnyObject {
    func oauthSignInNavigationController(navigator: OAuthSignInNavigator) -> UINavigationController
    
    func signInController(_ accessToken: String) -> UIViewController
}
