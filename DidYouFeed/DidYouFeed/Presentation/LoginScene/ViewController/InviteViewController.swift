//
//  InviteViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/14.
//

import UIKit

import ReactorKit
import RxKeyboard
import RxSwift
import SnapKit

final class InviteViewController: BaseOnboardViewController, View {
    typealias Reactor = InviteReactor
    
    // MARK: - Constants
    
    private enum Constant {
        static let addIcon = "person.fill.badge.plus"
    }
    
    private enum Metric {
        static let stackViewSpacing = 20.0
        static let viewSpacing = 80.0
        static let textFieldInset = 60.0
        static let stackViewMinHeight = 50.0
        static let newButtonSpacing = 8.0
        static let sectionSpacing = 8.0
        static let confirmButtonBottomOffset = 24.0
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
        
        $0.addArrangedSubview(self.inviteCodeSection)
    }
    
    private lazy var createDescriptionLabel = UILabel().then {
        $0.font = Font.regularText
        $0.text = "혹은 패밀리 중 첫 사용자이신가요?"
    }
    
    private lazy var createNewFamilyButton = UIButton(
        configuration: .plain()
    ).then {
        $0.configuration?.buttonSize = .mini
        $0.configuration?.attributedTitle = AttributedString("새로운 패밀리로 시작하기")
        $0.configuration?.baseForegroundColor = BrandColor.dfPeach
        $0.configuration?.image = UIImage(systemName: Constant.addIcon)
        $0.configuration?.imagePadding = 5
        $0.configuration?.imagePlacement = .leading
        $0.configuration?.titleAlignment = .center
    }
    
    private lazy var confirmButton = UIButton(
        configuration: .brandStyle(
            style: .main,
            title: "다음"
        )
    )
    
    // MARK: - Initializer
    
    init(reactor: InviteReactor) {
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
        self.updateKeyboard()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        self.inviteCodeSection.spacing = Metric.sectionSpacing
        self.textFieldStackView.spacing = Metric.stackViewSpacing
    }
    
    // MARK: - Binding
    
    func bind(reactor: InviteReactor) {
        
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
         self.createDescriptionLabel, self.confirmButton].forEach {
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
        
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func updateKeyboard() {
        RxKeyboard.instance.visibleHeight
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] visibleHeight in
                let safeAreaInset = self.view.safeAreaInsets.bottom > 0 ? self.view.safeAreaInsets.bottom : 34.0
                let height = visibleHeight > 0 ?
                    -visibleHeight + safeAreaInset - Metric.confirmButtonBottomOffset : 0
                self.confirmButton.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(height)
                }
                self.view.layoutIfNeeded()
            })
            .disposed(by: self.disposeBag)
    }
}
