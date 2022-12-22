//
//  LoginViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import UIKit

import ReactorKit
import RxCocoa
import RxKeyboard
import RxSwift
import SnapKit
import Then

final class LoginViewController: BaseOnboardViewController, View {
    typealias Reactor = LoginReactor
    typealias Available = Bool
    
    // MARK: - Constants
    
    private enum Constant {
        static let animationDuration = 0.15
    }
    
    private enum Metric {
        static let viewSpacing = 80.0
        static let textFieldInset = 60.0
        static let stackViewMinHeight = 50.0
        static let stackViewSpacing = 20.0
        static let sectionSpacing = 8.0
        static let descriptionSpacing = 12.0
        static let confirmButtonBottomOffset = 24.0
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
        $0.text = "."
        $0.font = Font.regularText
        $0.textColor = .red
    }
    
    private lazy var nicknameSection = self.createTextFieldSection(
        text: "당신을 어떻게 불러드릴까요?",
        textField: self.nicknameTextField,
        descriptionLabel: self.nicknameDescription
    )
    
    private lazy var textFieldStackView = UIStackView(frame: .zero).then {
        $0.axis = .vertical
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nicknameTextField.becomeFirstResponder()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Spacing을 StackView의 사이즈가 결정되기 전에 설정하면 constraint 충돌이 일어나 여기에서 설정.
        self.nicknameSection.spacing = Metric.sectionSpacing
        self.textFieldStackView.spacing = Metric.stackViewSpacing
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
        
        self.confirmButton.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            
            config?.showsActivityIndicator = (self.reactor?.currentState.validateNickname == .success)
            button.configuration = config
        }
        
        // State
        reactor.state.asObservable().map { $0.validateNickname }
            .distinctUntilChanged()
            .subscribe(onNext: { nicknameValidate in
                switch nicknameValidate {
                case .upperboundViolated, .lowerboundViolated, .invalid:
                    self.nicknameDescription.text = nicknameValidate.description
                    UIView.animate(withDuration: Constant.animationDuration) {
                        self.nicknameDescription.isHidden = false
                    }
                    self.nicknameTextField.isValid = false
                case .empty:
                    UIView.animate(withDuration: Constant.animationDuration) {
                        self.nicknameDescription.isHidden = true
                    }
                    self.nicknameTextField.isValid = true
                case .success:
                    UIView.animate(withDuration: Constant.animationDuration) {
                        self.nicknameDescription.isHidden = true
                    }
                    self.nicknameTextField.isValid = true
                }
                
                // Button Configuration
                self.confirmButton.configurationUpdateHandler = { button in
                    button.isEnabled = (nicknameValidate == .success)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Functions
    
    // MARK: - UI Setups
    
    override func setupLayouts() {
        super.setupLayouts()
        [self.textFieldStackView, self.confirmButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.nicknameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        self.textFieldStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.textFieldInset)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.viewSpacing)
        }
        
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }
    
    override func setupStyles() {
        super.setupStyles()
    }
    
    // MARK: - Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func updateKeyboard() {
        RxKeyboard.instance.visibleHeight
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] visibleHeight in
                let height = visibleHeight > 0 ?
                    -visibleHeight + self.view.safeAreaInsets.bottom - Metric.confirmButtonBottomOffset : 0
                self.confirmButton.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(height)
                }
                self.view.layoutIfNeeded()
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Private Functions

private extension LoginViewController {
    
    
    
}
