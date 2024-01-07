//
//  Resource.swift
//  MoA
//
//  Created by eunae on 2023/11/15.
//

import Foundation

extension Resource {
    
    static func signIn(accessToken: String) -> Resource<UserResponse> {
        let url = ApiContants.baseUrl.appendingPathComponent("/users/login/oauth2/kakao/app/\(accessToken)")
        return Resource<UserResponse>(url: url)
    }
    
}
