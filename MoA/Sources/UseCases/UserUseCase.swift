//
//  SignInUseCase.swift
//  MoA
//
//  Created by eunae on 2023/11/12.
//

import Foundation
import Combine
import UIKit.UIImage

protocol UserUseCaseType {
    func signIn(with accessToken: String) -> AnyPublisher<Result<User, Error>, Never>
}

final class UserUseCase: UserUseCaseType {
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func signIn(with accessToken: String) -> AnyPublisher<Result<User, Error>, Never> {
        return networkService
            .load(Resource<UserResponse>.signIn(accessToken: accessToken))
            .map{ .success($0.data) }
            .catch{ error -> AnyPublisher<Result<User, Error>, Never>
                in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
