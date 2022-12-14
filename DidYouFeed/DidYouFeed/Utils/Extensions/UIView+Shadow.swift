//
//  UIView+Shadow.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import UIKit

extension UIView {
    enum ShadowDirection {
        case top, bottom, leading, trailing
    }
    
    func addShadow(
        location: ShadowDirection,
        color: UIColor = .systemGray4,
        opacity: Float = 0.8,
        radius: CGFloat = 5.0
    ) {
        switch location {
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .leading:
            addShadow(offset: CGSize(width: -10, height: 0), color: color, opacity: opacity, radius: radius)
        case .trailing:
            addShadow(offset: CGSize(width: 10, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
