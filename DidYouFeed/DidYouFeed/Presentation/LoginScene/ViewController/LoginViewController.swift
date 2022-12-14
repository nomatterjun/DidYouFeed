//
//  LoginViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class LoginViewController: BaseOnboardViewController, View {
    typealias Reactor = LoginReactor
    typealias Available = Bool
    
    // MARK: - Constants
    
    private enum Metric {
        static let viewSpacing = 80.0
        static let textFieldInset = 60.0
        static let stackViewMinHeight = 50.0
        static let stackViewSpacing = 20.0
        static let sectionSpacing = 8.0
        static let descriptionSpacing = 12.0
    }
    
    private enum Font {
        static let regularText = UIFont.systemFont(ofSize: 13.0, weight: .light)
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var nicknameTextField = BaseTextField().then {
        $0.autocapitalizationType = .none
        $0.returnKeyType = .next
        $0.placeholder = "5~20자 이내에 입력해주세요."
    }
    
    private lazy var nicknameDescription = UILabel().then {
        $0.font = Font.regularText
        $0.textColor = .red
    }
    
    private lazy var nicknameSection = self.createTextFieldSection(
        text: "당신을 어떻게 불러드릴까요?",
        textField: self.nicknameTextField
    )
    
    private lazy var textFieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = Metric.stackViewSpacing
        
        $0.addArrangedSubview(self.nicknameSection)
    }
    
    private lazy var confirmButton = UIButton(
        configuration: .brandStyle(
            style: .main,
            title: "다음"
        )
    )
    
    // MARK: - Initializer
    
    init(reactor: LoginReactor) {
        super.init()
        self.reactor = reactor
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nicknameTextField.becomeFirstResponder()
    }
    
    // MARK: - Binding
    
    func bind(reactor: LoginReactor) {
        
        // Action
        self.nicknameTextField.rx.text
            .orEmpty
            .skip(1)
            .map { Reactor.Action.updateNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.confirmButton.rx.tap
            .map { Reactor.Action.confirmButtonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // State
        reactor.state.asObservable().map { $0.validateNickname }
            .subscribe(onNext: { nicknameValidate in
                switch nicknameValidate {
                case .upperboundViolated, .lowerboundViolated, .invalid:
                    self.nicknameDescription.isHidden = false
                    self.nicknameDescription.text = nicknameValidate.description
                    self.nicknameTextField.isValid = false
                    self.confirmButton.isUserInteractionEnabled = false
                    self.confirmButton.configuration?.updateStyle(to: .disabled)
                case .empty:
                    self.nicknameDescription.isHidden = true
                    self.nicknameTextField.isValid = true
                    self.confirmButton.isUserInteractionEnabled = false
                    self.confirmButton.configuration?.updateStyle(to: .disabled)
                case .success:
                    self.nicknameDescription.isHidden = true
                    self.nicknameTextField.isValid = true
                    self.confirmButton.isUserInteractionEnabled = true
                    self.confirmButton.configuration?.updateStyle(to: .main)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Functions
    
    // MARK: - UI Setups
    
    override func setupLayouts() {
        super.setupLayouts()
        [self.textFieldStackView,
         self.confirmButton, self.nicknameDescription].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.textFieldStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.textFieldInset)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.viewSpacing)
            make.height.greaterThanOrEqualTo(Metric.stackViewMinHeight).priority(.low)
        }
        
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.textFieldStackView.snp.bottom).offset(Metric.viewSpacing)
        }
        
        self.nicknameDescription.snp.makeConstraints { make in
            make.leading.equalTo(self.textFieldStackView.snp.leading)
            make.top.equalTo(self.textFieldStackView.snp.bottom).offset(Metric.descriptionSpacing)
        }
    }
    
    override func setupStyles() {
        super.setupStyles()
    }
}

// MARK: - Private Functions

private extension LoginViewController {
    
    
    
}
