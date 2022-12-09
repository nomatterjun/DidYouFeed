//
//  TaskListCell.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/08.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit
import Then

final class TaskListCell: BaseCollectionViewCell, View {
    typealias Reactor = TaskListCellViewModel
    
    // MARK: - Constants
    
    static let identifier = "TaskListCell"
    
    private enum Metric {
        static let dividerOpacity = 0.2
        static let dividerWidth = 1.0
        static let dividerRightPadding = 95.0
    }
    
    private enum Font {
        static let titleLabel = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    private enum Color {
        static let titleLabelText = BrandColor.dfWhite
    }
    
    // MARK: - Properties
    
    
    
    // MARK: - UI Components
    
    fileprivate let containerView = UIView().then {
        $0.backgroundColor = BrandColor.dfBeige
    }
    
    fileprivate let dividerView = UIView().then {
        $0.layer.opacity = Float(Metric.dividerOpacity)
        $0.snp.makeConstraints { make in
            make.width.equalTo(Metric.dividerWidth)
        }
    }
    
    fileprivate let isDoneIndicatorView = UIImageView().then {
        $0.isHidden = true
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = Font.titleLabel
        $0.textColor = Color.titleLabelText
    }
    
    // MARK: - Initializer
    
    override func configureCell() {
        self.configureLayout()
    }
    
    // MARK: - Binding
    
    func bind(reactor: TaskListCellViewModel) {
        self.containerView.backgroundColor = {
            switch reactor.currentState.isDone {
            case true:
                return BrandColor.dfBeige
            case false:
                return BrandColor.dfPeach
            }
        }()
        self.titleLabel.text = reactor.currentState.title
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureConstraints()
        self.configureStyles()
    }
}

// MARK: - UI Configuration
private extension TaskListCell {
    
    func configureLayout() {
        [self.containerView].forEach {
            self.contentView.addSubview($0)
        }
        [self.dividerView, self.titleLabel].forEach {
            self.containerView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.containerView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(260)
        }
        self.dividerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(Metric.dividerRightPadding)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.containerView.snp.leading).inset(24)
        }
    }
    
    func configureStyles() {
        self.titleLabel.sizeToFit()
    }
}

