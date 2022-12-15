//
//  JoinViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/14.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit

final class JoinViewController: BaseOnboardViewController, View {
    typealias Reactor = JoinReactor
    
    // MARK: - Constants
    
    private enum Metric {
        static let stackViewSpacing = 20.0
        static let viewSpacing = 80.0
        static let textFieldInset = 60.0
        static let stackViewMinHeight = 50.0
        static let newButtonSpacing = 8.0
    }
    
    private enum Font {
        static let regularText = UIFont.systemFont(ofSize: 13.0, weight: .light)
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    lazy var inviteCodeTextField = BaseTextField().then {
        $0.keyboardType = .asciiCapableNumberPad
        $0.textAlignment = .center
        $0.placeholder = "6자리 초대 코드를 입력해주세요"
    }
    
    private lazy var inviteCodeSection = self.createTextFieldSection(
        text: "이미 앱을 사용하는 지인이 있나요?",
        textField: self.inviteCodeTextField
    )
    
    private lazy var textFieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = Metric.stackViewSpacing
        
        $0.addArrangedSubview(self.inviteCodeSection)
    }
    
    private lazy var createDescriptionLabel = UILabel().then {
        $0.font = Font.regularText
        $0.text = "혹은 패밀리 중 첫 사용자이신가요?"
    }
    
    private lazy var createNewFamilyButton = UIButton(
        configuration: .brandStyle(
            style: .sub,
            title: "새로운 패밀리로 시작하기"
        )
    )
    
    // MARK: - Initializer
    
    init(reactor: JoinReactor) {
        super.init()
        self.reactor = reactor
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inviteCodeTextField.becomeFirstResponder()
    }
    
    // MARK: - Binding
    
    func bind(reactor: JoinReactor) {
        
        // Action
        self.createNewFamilyButton.rx.tap
            .map { Reactor.Action.newButtonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Functions
    
    // MARK: - UI Setups
    
    override func setupLayouts() {
        super.setupLayouts()
        [self.textFieldStackView, self.createNewFamilyButton,
         self.createDescriptionLabel].forEach {
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
        
        self.createDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.createNewFamilyButton.snp.top).inset(-Metric.newButtonSpacing)
            make.centerX.equalToSuperview()
        }
        
        self.createNewFamilyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.textFieldStackView.snp.bottom).offset(Metric.viewSpacing)
        }
    }
}
