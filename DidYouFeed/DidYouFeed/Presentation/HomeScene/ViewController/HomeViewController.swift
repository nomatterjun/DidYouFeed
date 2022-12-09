//
//  HomeViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

import ReactorKit
import RxCocoa
import RxDataSources
import RxGesture
import RxSwift
import SnapKit
import Then

final class HomeViewController: BaseViewController, View {
    typealias Reactor = HomeViewModel
    
    // MARK: - Constants
    
    private enum Metric {
        static let floatingButtonSize = 52.0
        static let floatingButtonBottomPadding = 52.0
    }
    
    private enum Icon {
        static let plus = "plus"
    }
    
    // MARK: - Properties
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<TaskListSection.TaskSectionModel> { dataSource, collectionView, indexPath, item in
        switch item {
        case let .sectionItem(task):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskListCell.identifier,
                for: indexPath) as? TaskListCell else {
                return UICollectionViewCell()
            }
            cell.titleLabel.text = task.title
            return cell
        }
    }
    
    // MARK: - UI Components
    
    private let petSelectorView = PetSelectorView().then {
        $0.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
//    private let testButton = UIButton().then {
//        $0.setTitleColor(.blue, for: .normal)
//        $0.setTitle("test", for: .normal)
//    }
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 200, height: 70)
        $0.scrollDirection = .vertical
    }
    
    lazy var collectionView = TaskListCollectionView(collectionViewLayout: self.collectionViewFlowLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.register(TaskListCell.self, forCellWithReuseIdentifier: TaskListCell.identifier)
    }
    
    private let floatingButton = FloatingButton(
        size: Metric.floatingButtonSize,
        icon: Icon.plus
    )
    
    // MARK: - Initializer
    
    init(reactor: HomeViewModel) {
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
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.configureConstraints()
    }
    
    // MARK: - Binding
    
    func bind(reactor: HomeViewModel) {
        // DataSource
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        // Action
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.floatingButton.rx.tap
            .map { Reactor.Action.buttonTap }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // State
        reactor.state.map { [$0.taskSection] }
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}

// MARK: - UI Configuration
private extension HomeViewController {
    
    func configureLayout() {
        [self.petSelectorView, self.collectionView].forEach {
            self.view.addSubview($0)
        }
        self.collectionView.addSubview(self.floatingButton)
    }
    
    func configureConstraints() {
        self.petSelectorView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.petSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        self.floatingButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.collectionView.frameLayoutGuide)
            make.bottom.equalTo(self.collectionView.frameLayoutGuide).inset(Metric.floatingButtonBottomPadding)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = BrandColor.dfWhite
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.window?.windowScene?.screen.bounds.width)!, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
}
