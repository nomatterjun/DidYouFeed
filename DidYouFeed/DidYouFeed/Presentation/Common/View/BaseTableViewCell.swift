//
//  BaseTableViewCell.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/16.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configureCell() {
        // override
    }
}
