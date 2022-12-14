//
//  BaseTextField.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import UIKit

class BaseTextField: UITextField {
    
    // MARK: - Constants
    
    private enum Metric {
        static let cornerRadius = 4.0
    }
    
    private enum Font {
        static let title = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let regular = UIFont.systemFont(ofSize: 13, weight: .light)
    }
    
    private enum Color {
        static let backgroundColor = UIColor.systemGray6
        static let validBorderColor = UIColor.clear.cgColor
        static let invalidBorderColor = UIColor.red.cgColor
    }
    
    // MARK: - Properties
    
    var isValid: Bool = true {
        willSet {
            if newValue {
                self.layer.borderColor = Color.validBorderColor
            } else {
                self.layer.borderColor = Color.invalidBorderColor
            }
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
private extension BaseTextField {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureStyles() {
        self.autocorrectionType = .no
        self.enablesReturnKeyAutomatically = true
        self.font = Font.regular
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = Metric.cornerRadius
        self.borderStyle = .roundedRect
        self.backgroundColor = BrandColor.dfBeige
        self.font = Font.title
    }
}

