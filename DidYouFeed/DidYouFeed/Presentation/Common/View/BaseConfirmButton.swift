//
//  BaseConfirmButton.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import UIKit

import SnapKit

class BaseConfirmButton: UIButton {
    
    // MARK: - Constants
    
    private enum Metric {
        static let buttonSize = 72.0
    }
    
    // MARK: - Properties
    
    var isAvailable: Bool = false {
        willSet {
            switch newValue {
            case true:
                self.isUserInteractionEnabled = true
                self.backgroundColor = BrandColor.dfPeach
            case false:
                self.isUserInteractionEnabled = false
                self.backgroundColor = .systemGray4
            }
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
private extension BaseConfirmButton {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        
    }
    
    func configureConstraints() {
        self.snp.makeConstraints { make in
            make.height.width.equalTo(Metric.buttonSize)
        }
    }
    
    func configureStyles() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        self.layer.cornerRadius = Metric.buttonSize / 2
    }
}

