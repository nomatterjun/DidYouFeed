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
    typealias Reactor = HomeViewReactor
    
    // MARK: - Constants
    
    private enum Metric {
        static let floatingButtonSize = 52.0
        static let floatingButtonBottomPadding = 52.0
        
        static let cellHeight = 70.0
    }
    
    private enum Icon {
        static let plus = "plus"
    }
    
    // MARK: - Properties
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<TaskListSectionModel>(
        configureCell: { dataSource, collectionView, indexPath, reactor in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskListCell.identifier,
                for: indexPath) as? TaskListCell else { return UICollectionViewCell() }
            cell.reactor = reactor
            return cell
    })
    
    // MARK: - UI Components
    
    private let petSelectorView = PetSelectorView().then {
        $0.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        $0.minimumLineSpacing = 10
        $0.scrollDirection = .vertical
    }
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.collectionViewFlowLayout
    ).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.register(TaskListCell.self, forCellWithReuseIdentifier: TaskListCell.identifier)
    }
    
    private let bottomMenuView = UIView().then {
        $0.backgroundColor = .clear
        $0.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
    }
    
    private let floatingButton = FloatingButton(
        size: Metric.floatingButtonSize,
        icon: Icon.plus
    )
    
    // MARK: - Initializer
    
    init(reactor: HomeViewReactor) {
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
    
    func bind(reactor: HomeViewReactor) {
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
        
        self.collectionView.rx.itemSelected
            .map { indexPath in
                Reactor.Action.toggleTaskDone(indexPath)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // State
        reactor.state.map { $0.taskSections }
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}

// MARK: - UI Configuration
private extension HomeViewController {
    
    func configureLayout() {
        [self.petSelectorView, self.collectionView, self.bottomMenuView].forEach {
            self.view.addSubview($0)
        }
        self.bottomMenuView.addSubview(self.floatingButton)
    }
    
    func configureConstraints() {
        self.petSelectorView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(24)
        }
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.petSelectorView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.bottomMenuView.snp.top)
        }
        self.bottomMenuView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        self.floatingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = BrandColor.dfWhite
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.window?.windowScene?.screen.bounds.width)!, height: Metric.cellHeight)
    }
}
