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
    typealias Reactor = TaskListCellReactor
    
    // MARK: - Constants
    
    static let identifier = "TaskListCell"
    
    private enum Metric {
        static let cellCornerRadius = 12.0
        static let minimumCellWidth = 300.0
        static let dividerOpacity = 0.5
        static let dividerWidth = 1.0
        static let dividerRightPadding = 95.0
        static let iconImageLeftPadding = 24.0
        static let labelStackLeftPadding = 16.0
        static let taskConductorImageSize = 28.0
        static let taskConductorRightPadding = 12.0
    }
    
    private enum Font {
        static let titleLabel = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let timeLabel = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    private enum Color {
        static let labelText = BrandColor.dfWhite
    }
    
    // MARK: - Properties
    
    
    
    // MARK: - UI Components
    
    fileprivate let containerView = UIView().then {
        $0.layer.cornerRadius = Metric.cellCornerRadius
        $0.backgroundColor = BrandColor.dfBeige
    }
    
    fileprivate let dividerView = UIView().then {
        $0.backgroundColor = BrandColor.dfWhite
        $0.layer.opacity = Float(Metric.dividerOpacity)
        $0.snp.makeConstraints { make in
            make.width.equalTo(Metric.dividerWidth)
        }
    }
    
    fileprivate let isDoneIndicatorView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = BrandColor.dfWhite
    }
    
    lazy var iconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = BrandColor.dfWhite
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = Font.titleLabel
        $0.textColor = Color.labelText
    }
    
    lazy var timeLabel = UILabel().then {
        $0.text = "09:00"
        $0.font = Font.timeLabel
        $0.textColor = Color.labelText
    }
    
    private let labelStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    lazy var taskConductorImageView = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.layer.cornerRadius = Metric.taskConductorImageSize / 2
        $0.clipsToBounds = true
        $0.snp.makeConstraints { make in
            make.width.height.equalTo(Metric.taskConductorImageSize)
        }
    }
    
    // MARK: - Initializer
    
    override func configureCell() {
        self.configureLayout()
    }
    
    // MARK: - Binding
    
    func bind(reactor: TaskListCellReactor) {
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
        [self.containerView, self.taskConductorImageView].forEach {
            self.contentView.addSubview($0)
        }
        [self.dividerView, self.iconImageView,
         self.labelStackView, self.isDoneIndicatorView].forEach {
            self.containerView.addSubview($0)
        }
        [self.titleLabel, self.timeLabel].forEach {
            self.labelStackView.addArrangedSubview($0)
        }
    }
    
    func configureConstraints() {
        self.containerView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.greaterThanOrEqualTo(Metric.minimumCellWidth)
        }
        self.dividerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(Metric.dividerRightPadding)
        }
        self.iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.containerView.snp.leading).inset(Metric.iconImageLeftPadding)
        }
        self.labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(Metric.labelStackLeftPadding)
        }
        self.isDoneIndicatorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
        }
        self.taskConductorImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.containerView.snp.leading).inset(-Metric.taskConductorRightPadding)
        }
    }
    
    func configureStyles() {
        self.titleLabel.sizeToFit()
    }
}

