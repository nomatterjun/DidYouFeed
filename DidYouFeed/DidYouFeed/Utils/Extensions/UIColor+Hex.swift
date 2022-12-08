//
//  UIColor+Hex.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/06.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double((rgb >> 0) & 0xFF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
