//
//  ApplicationFlowCoordinator.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import UIKit

class ApplicationFlowCoordinator: FlowCoordinator {
    
    typealias DependencyProvider = ApplicationFlowCoordinatorDependencyProvider

    private let window: UIWindow
    private let dependencyProvider: DependencyProvider
    private var childCoordinators = [FlowCoordinator]()

    init(window: UIWindow, dependencyProvider: DependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let oauthSignInFlowCoordinator = OAuthSignInFlowCoordinator(window: window, dependencyProvider:dependencyProvider)
        childCoordinators = [oauthSignInFlowCoordinator]
        oauthSignInFlowCoordinator.start()
    }
}
