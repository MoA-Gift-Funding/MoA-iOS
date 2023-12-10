//
//  Resource.swift
//  MoA
//
//  Created by eunae on 2023/11/05.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL
    let parameters: [String: CustomStringConvertible]
    var request: URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    init(url: URL, parameters: [String : CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}
