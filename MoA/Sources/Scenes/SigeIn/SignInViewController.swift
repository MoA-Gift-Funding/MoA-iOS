//
//  SignInViewController.swift
//  MoA
//
//  Created by eunae on 2023/08/13.
//

import UIKit
import Foundation
import Combine

import KakaoSDKUser
import NaverThirdPartyLogin
import GoogleSignIn
import AuthenticationServices


class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInProgressView: UIProgressView!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameModifyButton: UIButton!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberModifyButton: UIButton!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var birthdayModifyButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private let viewModel: SignInViewModelType
    private var cancellables: [AnyCancellable] = []
    private let appear = PassthroughSubject<Void, Never>()
    
    
    init(viewModel: SignInViewModelType) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear.send(())
    }
    
    private func configureUI() {
        self.signInProgressView.progress  = 0.2
        
        self.nickNameTextField.layer.cornerRadius = 8
        self.phoneNumberTextField.layer.cornerRadius = 8
        self.birthdayTextField.layer.cornerRadius = 8
        
        self.nextButton.layer.cornerRadius = 8
    }
    
    private func bind(to viewModel: SignInViewModelType) {
        let input = SignInViewModelInput(appear: appear.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: SignInState) {
        switch state {
        case .loading:
            print("loading")
        case .failure:
            print("fail")
        case .success(let user):
            show(user)
        }
    }
    
    private func show(_ user: UserViewModel) {
        nickNameTextField.text = user.nickname
        phoneNumberTextField.text = user.phoneNumber
        birthdayTextField.text = user.birthday
    }
}
    
