//
//  NewFamilyViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/15.
//

import UIKit

import ReactorKit
import RxDataSources
import RxKeyboard
import RxSwift
import SnapKit
import Then

final class NewFamilyViewController: BaseOnboardViewController, View {
    typealias Reactor = NewFamilyReactor
    
    // MARK: - Constants
    
    private enum Constant {
        static let addIcon = "plus.circle.fill"
    }
    
    private enum Metric {
        static let stackViewSpacing = 20.0
        static let viewSpacing = 60.0
        static let textFieldInset = 60.0
        static let stackViewMinHeight = 50.0
        static let sectionSpacing = 8.0
        static let confirmButtonBottomOffset = 24.0
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    lazy var familyNameTextField = BaseTextField().then {
        $0.autocapitalizationType = .none
        $0.returnKeyType = .next
        $0.placeholder = "3~20자 이내에 입력해주세요."
    }
    
    private lazy var familyNameSection = self.createTextFieldSection(
        text: "당신의 소중한 패밀리에 이름을 붙여주세요.",
        textField: self.familyNameTextField
    )
    
    private lazy var petListTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(PetListCell.self, forCellReuseIdentifier: PetListCell.identifier)
        $0.rowHeight = 30
    }
    
    private lazy var addPetButton = UIButton(
        configuration: .plain()
    ).then {
        $0.configuration?.buttonSize = .mini
        $0.configuration?.attributedTitle = AttributedString("펫 추가하기")
        $0.configuration?.baseForegroundColor = BrandColor.dfPeach
        $0.configuration?.image = UIImage(systemName: Constant.addIcon)
        $0.configuration?.imagePadding = 5
        $0.configuration?.imagePlacement = .leading
        $0.configuration?.titleAlignment = .center
    }
    
    private lazy var addPetSection = self.createTextFieldSection(
        text: "귀여운 반려동물을 추가해주세요."
    ).then {
        $0.addArrangedSubview(self.petListTableView)
        $0.addArrangedSubview(self.addPetButton)
    }
    
    private lazy var textFieldStackView = UIStackView().then {
        $0.axis = .vertical
        
        $0.addArrangedSubview(self.familyNameSection)
        $0.addArrangedSubview(self.addPetSection)
    }
    
    private lazy var confirmButton = UIButton(
        configuration: .brandStyle(
            style: .main,
            title: "완료"
        )
    )
    
    // MARK: - Initializer
    
    init(reactor: NewFamilyReactor) {
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
        self.familyNameTextField.becomeFirstResponder()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        self.familyNameSection.spacing = Metric.sectionSpacing
        self.addPetSection.spacing = Metric.sectionSpacing
        self.textFieldStackView.spacing = Metric.stackViewSpacing
    }
    
    // MARK: - Binding
    
    func bind(reactor: NewFamilyReactor) {
        
        // Action
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.familyNameTextField.rx.text
            .orEmpty
            .skip(1)
            .map { Reactor.Action.updateFamilyName($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.addPetButton.rx.tap
            .map { Reactor.Action.addPetButtonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.confirmButton.rx.tap
            .map { Reactor.Action.confirmButtonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // State
        let dataSource = RxTableViewSectionedReloadDataSource<PetListSection.PetListSectionModel> { dataSource, tableView, indexPath, item in
            Self.configureTableViewCell(
                tableView: tableView,
                indexPath: indexPath,
                item: item
            )
        }
        
        reactor.state.map { $0.petListSection }
            .distinctUntilChanged()
            .map { [$0] }
            .bind(to: self.petListTableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Functions
    
    private static func configureTableViewCell(
        tableView: UITableView,
        indexPath: IndexPath,
        item: PetListSection.PetItem
    ) -> PetListCell {
        switch item {
        case let .standard(pet):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PetListCell.identifier,
                for: indexPath) as? PetListCell else {
                return PetListCell(style: .default, reuseIdentifier: nil)
            }
            cell.setPet(pet)
            return cell
        }
    }
    
    // MARK: - UI Setups
    
    override func setupLayouts() {
        super.setupLayouts()
        [self.textFieldStackView, self.confirmButton].forEach {
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
