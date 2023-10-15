//
//  SignInViewController.swift
//  MoA
//
//  Created by eunae on 2023/08/13.
//

import UIKit
import Foundation
import KakaoSDKUser
import NaverThirdPartyLogin

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
    }
    
    @IBAction func naverButtonDidTap(_ sender: UIButton) {
        NaverThirdPartyLoginConnection.getSharedInstance().requestThirdPartyLogin()
    }
    
    @IBAction func kakaoButtonDidTap(_ sender: UIButton) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    
                    self.setUserInfo()
                }
            }
        } else {
            print("안됨")
        }
    }
    
    @IBAction func googleButtonDidTap(_ sender: UIButton) {
    }
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                /*self.infoLabel.text = user?.kakaoAccount?.profile?.nickname
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                   let data = try? Data(contentsOf: url) {
                    self.profileImageView.image = UIImage(data: data)
                }*/
            }
        }
    }
}

extension SignInViewController: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        guard let accessToken = NaverThirdPartyLoginConnection.getSharedInstance()?.accessToken else { return }
        print(accessToken)
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
    }
}
