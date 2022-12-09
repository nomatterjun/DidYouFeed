//
//  BaseCollectionViewCell.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/08.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        // Override
    }
}
