//
//  NetworkServiceType.swift
//  MoA
//
//  Created by eunae on 2023/11/05.
//

import Foundation
import Combine

protocol NetworkServiceType: AnyObject {
    
    @discardableResult
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error>
}

/// Defines the Network service errors.
enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case dataLoadingError(statusCode: Int, data: Data)
    case jsonDecodingError(error: Error)
}
