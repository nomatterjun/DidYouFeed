//
//  PetListCell.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/16.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit
import Then

final class PetListCell: BaseTableViewCell, View {
    typealias Reactor = PetListCellReactor
    
    // MARK: - Constants
    
    static let identifier = "petListCell"
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    private lazy var iconLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    // MARK: - Initializer
    
    // MARK: - Life Cycle
    
    override func configureCell() {
        self.addSubview(self.nameLabel)
        self.addSubview(self.iconLabel)
        
        self.nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.iconLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.nameLabel.snp.leading).offset(8)
        }
    }
    
    // MARK: - Binding
    
    func bind(reactor: PetListCellReactor) {
        self.nameLabel.text = reactor.currentState.name
    }
}
