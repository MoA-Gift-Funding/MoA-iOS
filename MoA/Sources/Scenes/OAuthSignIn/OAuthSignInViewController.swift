//
//  OAuthSignInViewController.swift
//  MoA
//
//  Created by eunae on 2023/12/09.
//

import UIKit
import Foundation
import Combine

import KakaoSDKUser
import NaverThirdPartyLogin
import GoogleSignIn
import AuthenticationServices


class OAuthSignInViewController: UIViewController {

    private var cancellables: [AnyCancellable] = []
    private let viewModel: OAuthSignInViewModelType
    private let signIn = PassthroughSubject<String, Never>()
    
    @IBOutlet weak var naverButton: UIButton!
    @IBOutlet weak var kakaoButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    init(viewModel: OAuthSignInViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind(to: viewModel)
        
        NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
    }
    
    private func configureUI() {
        self.naverButton.layer.cornerRadius = 8
        self.kakaoButton.layer.cornerRadius = 8
        self.googleButton.layer.cornerRadius = 8
        self.appleButton.layer.cornerRadius = 8
    }
    
    private func bind(to viewModel: OAuthSignInViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let input = OAuthSignInViewModelInput(signIn: signIn.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: OAuthSignInState) {
        switch state {
        case .loading:
            print("loading")
        case .failure:
            print("fail")
        case .success:
            print("success")
        }
    }
    
    @IBAction func naverButtonDidTap(_ sender: UIButton) {
        NaverThirdPartyLoginConnection.getSharedInstance().requestThirdPartyLogin()
    }
    
    @IBAction func kakaoButtonDidTap(_ sender: UIButton) {
        if UserApi.isKakaoTalkLoginAvailable() {
            
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    guard let accessToken = oauthToken?.accessToken else {
                        return
                    }
                    self.signIn.send(accessToken)
                }
            }
        } else {
            print("loginWithKakaoTalk() fail.")
        }
    }
    
    @IBAction func googleButtonDidTap(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, _ in
            guard let self,
                  let result = signInResult,
                  let token = result.user.idToken?.tokenString else { return }
            // 서버에 토큰을 보내기. 이 때 idToken, accessToken 차이에 주의할 것
        }
    }
    
    @IBAction func appleButtonDidTap(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] //유저로 부터 알 수 있는 정보들(name, email)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

extension OAuthSignInViewController: NaverThirdPartyLoginConnectionDelegate {
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

extension OAuthSignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // You can create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("identifyTokenString: \(identifyTokenString)")
            }
            
            print("useridentifier: \(userIdentifier)")
            print("fullName: \(String(describing: fullName))")
            print("email: \(String(describing: email))")
            
            //Move to MainPage
            //let validVC = SignValidViewController()
            //validVC.modalPresentationStyle = .fullScreen
            //present(validVC, animated: true, completion: nil)
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 로그인 실패(유저의 취소도 포함)
        print("login failed - \(error.localizedDescription)")
    }
}
