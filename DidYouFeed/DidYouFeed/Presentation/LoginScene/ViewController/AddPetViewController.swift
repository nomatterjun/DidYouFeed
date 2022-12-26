//
//  AddPetViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/19.
//

import UIKit

import ReactorKit
import RxCocoa
import RxDataSources
import RxKeyboard
import SnapKit
import Then

final class AddPetViewController: BaseViewController, View {
    typealias Reactor = AddPetReactor
    
    // MARK: - Constants
    
    private enum Metric {
        static let viewTopInset = 24.0
        static let petImageViewSize = 100.0
        static let confirmButtonBottomOffset = 24.0
        static let stackViewSpacing = 12.0
    }
    
    private enum Font {
        static let nameText = UIFont.systemFont(ofSize: 21.0, weight: .semibold)
        static let regularText = UIFont.systemFont(ofSize: 13.0, weight: .light)
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var petImageButton = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = Metric.petImageViewSize / 2
        $0.backgroundColor = BrandColor.dfPink
    }
    
    private lazy var nameTextField = UITextField().then {
        $0.becomeFirstResponder()
        $0.enablesReturnKeyAutomatically = true
        $0.returnKeyType = .done
        $0.textAlignment = .center
        $0.placeholder = "이름을 입력해주세요."
        $0.font = Font.nameText
    }
    
    private lazy var speciesLabel = UILabel().then {
        $0.text = "당신의 펫은 어떤 친구인가요?"
        $0.font = Font.regularText
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.configureCollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(SpeciesCell.self, forCellWithReuseIdentifier: SpeciesCell.identifier)
    }
    
    private lazy var stackView = UIStackView(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 300))).then {
        $0.alignment = .center
        $0.axis = .vertical
        
        $0.addArrangedSubview(self.petImageButton)
        $0.addArrangedSubview(self.nameTextField)
        $0.addArrangedSubview(self.speciesLabel)
        $0.addArrangedSubview(self.collectionView)
    }
    
    private lazy var confirmButton = UIButton(
        configuration: .brandStyle(
            style: .main,
            title: "완료"
        )
    )
    
    // MARK: - Initializer
    
    init(reactor: AddPetReactor) {
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
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        self.stackView.spacing = Metric.stackViewSpacing
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        [self.stackView, self.confirmButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.petImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(Metric.petImageViewSize)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(Metric.viewTopInset)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(Metric.petImageViewSize)
        }
        
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }
    
    override func setupStyles() {
        super.setupStyles()
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            // Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(0.1)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layout
    }
    
    // MARK: - Binding
    
    func bind(reactor: AddPetReactor) {
        
        // Action
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.nameTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.updateNameTextField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.petImageButton.rx.tap
            .map { _ in Reactor.Action.petImageButtonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.confirmButton.rx.tap
            .map { Reactor.Action.confirmButtonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // State
        let dataSource = RxCollectionViewSectionedReloadDataSource<SpeciesSection.SpeciesModel> {
            dataSource, collectionView, indexPath, item in
            switch item {
            case .specified(let emoji):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SpeciesCell.identifier,
                    for: indexPath) as? SpeciesCell else {
                    return UICollectionViewCell()
                }
                cell.bind(emoji: emoji)
                return cell
            }
        }
        
        reactor.state.asObservable().map { $0.speciesSection }
            .skip(1)
            .map { [$0] }
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        reactor.state.asObservable().map { $0.pet }
            .distinctUntilChanged()
            .subscribe(onNext: {
                print($0.image?.toImage()) // TODO: UIImage String으로 변경해서 출력하면 쥰내게 길다... 루프 걸린걸로 알 정도로;
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.asObservable().map { $0.petImage }
            .bind(to: self.petImageButton.rx.image())
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Functions
    
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
