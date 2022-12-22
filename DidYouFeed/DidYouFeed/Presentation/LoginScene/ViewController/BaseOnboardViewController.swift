//
//  BaseOnboardViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/14.
//

import UIKit

import SnapKit

class BaseOnboardViewController: BaseViewController {
    
    // MARK: - Constants
    
    private enum Constant {
        static let titleLabelNumberOfLines = 2
    }
    private enum Metric {
        static let titleLabelInset = 20.0
        static let sectionSpacing = 8.0
    }
    
    private enum Font {
        static let regularText = UIFont.systemFont(ofSize: 13.0, weight: .light)
        static let titleLabel = UIFont.systemFont(ofSize: 17.0, weight: .light)
        static let highlightedTitleLabel = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
    }
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    lazy var titleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    // MARK: - Functions
    
    func createTitleLabel(text: String, highlightText: String? = nil) -> UILabel {
        let attributedText = NSMutableAttributedString(string: text)
        if let highlightText {
            let highlightRange = (text as NSString).range(of: highlightText)
            attributedText.addAttribute(.font, value: Font.highlightedTitleLabel, range: highlightRange)
        }
        
        let label = UILabel().then {
            $0.font = Font.titleLabel
            $0.numberOfLines = Constant.titleLabelNumberOfLines
            $0.textAlignment = .center
            $0.attributedText = attributedText
        }
        return label
    }
    
    func createTextFieldSection(
        text: String,
        textField: UITextField? = nil,
        descriptionLabel: UILabel? = nil
    ) -> UIStackView {
        // StackView
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        
        // Title Label
        let titleLabel = UILabel().then {
            $0.font = Font.regularText
            $0.text = text
        }
        stackView.addArrangedSubview(titleLabel)
        
        // TextField
        if let textField {
            stackView.addArrangedSubview(textField)
        }
        
        // Description Label
        if let descriptionLabel {
            stackView.addArrangedSubview(descriptionLabel)
        }
        
        return stackView
    }
    
    // MARK: - UI Setups
    
    override func setupLayouts() {
        super.setupLayouts()
        [self.titleLabel].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.titleLabelInset)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Metric.titleLabelInset)
        }
    }
}
