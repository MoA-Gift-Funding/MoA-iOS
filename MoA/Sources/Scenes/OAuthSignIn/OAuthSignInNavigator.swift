//
//  OAuthSignInNavigator.swift
//  MoA
//
//  Created by eunae on 2023/12/10.
//

import Foundation

protocol OAuthSignInNavigator: AutoMockable, AnyObject {
    func signIn(forSignIn accessToken: String)
}
