//
//  BaseFloatingButton.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/08.
//

import UIKit

import Then
import SnapKit

class BaseFloatingButton: UIButton {
    
    // MARK: - UI Components
    
    private let iconImage = UIImageView().then {
        $0.tintColor = BrandColor.dfWhite
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureButton()
    }
    
    convenience init(size: CGFloat, icon: String) {
        self.init(frame: .zero)
        self.configureBaseStyle(size: size, icon: icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func configureBaseStyle(size: CGFloat, icon: String) {
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        self.backgroundColor = BrandColor.dfPeach
        self.layer.cornerRadius = size / 2
        self.snp.makeConstraints { make in
            make.width.height.equalTo(size)
        }
        
        self.addSubview(self.iconImage)
        let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .semibold))
        self.iconImage.image = UIImage(systemName: icon, withConfiguration: configuration)
        self.iconImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureButton() {
        // Override
    }
}
