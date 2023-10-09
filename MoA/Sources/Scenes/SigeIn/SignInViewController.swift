//
//  SignInViewController.swift
//  MoA
//
//  Created by eunae on 2023/08/13.
//

import UIKit
import Foundation
import KakaoSDKUser

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
