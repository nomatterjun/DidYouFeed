//
//  PetSelectorView.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/06.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import Then

final class PetSelectorView: UIView {
    
    // MARK: - Constants
    
    private enum Metric {
        static let imageSize = 32.0
        static let imagePadding = 12.0
    }
    
    // MARK: - UI Components
    
    fileprivate let imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .magenta
        $0.layer.cornerRadius = Metric.imageSize / 2
        $0.snp.makeConstraints { make in
            make.width.height.equalTo(Metric.imageSize)
        }
    }
    
    fileprivate let speciesLabel = UILabel().then {
        $0.text = "견종"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    fileprivate let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    fileprivate let vStack = UIStackView().then {
        $0.axis = .vertical
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
private extension PetSelectorView {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [imageView, vStack].forEach {
            self.addSubview($0)
        }
        [speciesLabel, nameLabel].forEach {
            self.vStack.addArrangedSubview($0)
        }
    }
    
    func configureConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
                .inset(Metric.imagePadding)
        }
        self.vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.imageView.snp.trailing)
                .offset(Metric.imagePadding)
        }
    }
    
    func configureStyles() {
        self.isUserInteractionEnabled = true
    }
}

// MARK: - Reactive

extension Reactive where Base: PetSelectorView {

    
    
}
