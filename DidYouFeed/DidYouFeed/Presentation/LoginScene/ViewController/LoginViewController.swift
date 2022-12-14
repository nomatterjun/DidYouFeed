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

final class LoginViewController: BaseViewController, View {
    typealias Reactor = LoginReactor
    typealias Available = Bool
    
    // MARK: - Constants
    
    private enum Constant {
        static let titleLabelNumberOfLines = 2
    }
    
    private enum Metric {
        static let titleLabelInset = 20.0
        static let viewSpacing = 80.0
        static let textFieldInset = 60.0
        static let stackViewMinHeight = 50.0
        static let stackViewSpacing = 20.0
        static let sectionSpacing = 8.0
        static let descriptionSpacing = 12.0
    }
    
    private enum Font {
        static let titleLabel = UIFont.systemFont(ofSize: 17.0, weight: .light)
        static let highlightedTitleLabel = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        static let sectionTitle = UIFont.systemFont(ofSize: 13.0, weight: .light)
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var titleLabel = UILabel().then {
        $0.font = Font.titleLabel
        $0.numberOfLines = Constant.titleLabelNumberOfLines
        $0.textAlignment = .center
        let text = "안녕하세요 펫밀리님.\n당신에 대해 알려주세요."
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "펫밀리")
        attributedString.addAttribute(.font, value: Font.highlightedTitleLabel, range: range)
        $0.attributedText = attributedString
    }
    
    private lazy var nicknameTextField = BaseTextField().then {
        $0.font = Font.sectionTitle
        $0.autocorrectionType = .no
        $0.enablesReturnKeyAutomatically = true
        $0.returnKeyType = .next
        $0.placeholder = "5~20자 이내에 입력해주세요."
    }
    
    private lazy var nicknameDescription = UILabel().then {
        $0.font = Font.sectionTitle
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
    
    private lazy var confirmButton = BaseConfirmButton(title: "완료")
    
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
        self.configureLayout()
        self.configureStyles()
        self.nicknameTextField.becomeFirstResponder()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.configureConstraints()
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
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: self.disposeBag)
        
        // State
        reactor.state.asObservable().map { $0.validateNickname }
            .subscribe(onNext: { nicknameValidate in
                switch nicknameValidate { // TODO: 🗑️ 더티 코드 리팩토링
                case .upperboundViolated, .lowerboundViolated, .invalid:
                    self.nicknameDescription.isHidden = false
                    self.nicknameDescription.text = nicknameValidate.description
                    self.nicknameTextField.isValid = false
                    self.confirmButton.isAvailable = false
                case .empty:
                    self.nicknameDescription.isHidden = true
                    self.nicknameTextField.isValid = true
                    self.confirmButton.isAvailable = false
                case .success:
                    self.nicknameDescription.isHidden = true
                    self.nicknameTextField.isValid = true
                    self.confirmButton.isAvailable = true
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Functions
    
    
}

// MARK: - UI Configuration

private extension LoginViewController {
    
    func configureLayout() {
        [self.titleLabel, self.textFieldStackView,
         self.confirmButton, self.nicknameDescription].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.titleLabelInset)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Metric.titleLabelInset)
        }
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
    
    func configureStyles() {
        self.view.backgroundColor = BrandColor.dfWhite
    }
    
    func createTextFieldSection(
        text: String,
        textField: UITextField
    ) -> UIView {
        let titleLabel = UILabel().then {
            $0.font = Font.sectionTitle
            $0.text = text
        }
        
        let containerView = UIView()
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(textField)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Metric.sectionSpacing)
            make.leading.trailing.equalToSuperview()
        }
        
        return containerView
    }
}

// MARK: - Private Functions

private extension LoginViewController {
    
    
    
}
