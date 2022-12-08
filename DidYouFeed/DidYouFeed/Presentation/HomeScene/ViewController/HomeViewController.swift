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
import RxSwift
import SnapKit
import Then

final class HomeViewController: BaseViewController, View {
    typealias Reactor = HomeViewModel
    
    // MARK: - Properties
    
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
    
    private let collectionView = ToDoListCollectionView()
    
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
        
        // Action
        
//        self.testButton.rx.tap
//            .map { Reactor.Action.buttonTap }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
        
    }
}

// MARK: - UI Configuration
private extension HomeViewController {
    
    func configureLayout() {
        [self.petSelectorView, self.collectionView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.petSelectorView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        self.collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
//        self.testButton.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.height.equalTo(100)
//        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = BrandColor.dfWhite
    }
}

