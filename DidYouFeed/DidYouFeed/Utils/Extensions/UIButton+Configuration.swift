//
//  UIButton+Configuration.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/14.
//

import UIKit

@available(iOS 15.0, *)
extension UIButton.Configuration {
    enum BrandStyle {
        case main, sub, disabled
        
        var backgroundColor: UIColor? {
            switch self {
            case .main:
                return BrandColor.dfPeach
            case .sub:
                return BrandColor.dfBeige
            case .disabled:
                return UIColor.systemGray6
            }
        }
        
        var foregroundcolor: UIColor? {
            switch self {
            case .main:
                return BrandColor.dfWhite
            case .sub:
                return BrandColor.dfPeach
            case .disabled:
                return UIColor.systemGray4
            }
        }
    }
    
    static func brandStyle(style: BrandStyle, title: String? = nil) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = style.foregroundcolor
        configuration.baseBackgroundColor = style.backgroundColor
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 5
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        return configuration
    }
    
    mutating func updateStyle(to style: BrandStyle) {
        var configuration = self
        configuration.baseForegroundColor = style.foregroundcolor
        configuration.baseBackgroundColor = style.backgroundColor
        self = configuration
    }
}
