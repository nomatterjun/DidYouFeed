//
//  SpeciesCell.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/20.
//

import UIKit

import SnapKit
import Then

final class SpeciesCell: BaseCollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "speciesCell"
    
    // MARK: - UI Components
    
    private lazy var emojiLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    // MARK: - Life Cycle
    
    override func configureCell() {
        
        // Layout
        self.addSubview(self.emojiLabel)
        
        // Constraints
        self.emojiLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    func bind(emoji: String) {
        self.emojiLabel.text = emoji
    }
}
