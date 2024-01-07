//
//  SignInViewController.swift
//  MoA
//
//  Created by eunae on 2023/08/13.
//

import UIKit
import Foundation
import Combine


class EnterUserInfoViewController: UIViewController {
    
    @IBOutlet weak var nicknameView: UIView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nicknameModifyButton: UIButton!
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberModifyButton: UIButton!
    
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var birthdayModifyButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
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
        configure()
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear.send(())
    }
    
    private func configure() {
        self.navigationController?.navigationBar.topItem?.title = ""
        
        nicknameTextField.delegate = self
        phoneNumberTextField.delegate = self
        birthdayTextField.delegate = self
        
        nicknameView.layer.cornerRadius = 8
        phoneNumberView.layer.cornerRadius = 8
        birthdayView.layer.cornerRadius = 8
        
        nextButton.layer.cornerRadius = 8
    }
    
    private func bind(to viewModel: SignInViewModelType) {
        cancellables.forEach { $0.cancel() }
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
        nicknameTextField.text = user.nickname
        phoneNumberTextField.text = user.phoneNumber
        birthdayTextField.text = user.birthday
    }
    
    @objc func doneBtnClicked (sender: Any) {
        view.endEditing(true)
    }
}

extension EnterUserInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
    
