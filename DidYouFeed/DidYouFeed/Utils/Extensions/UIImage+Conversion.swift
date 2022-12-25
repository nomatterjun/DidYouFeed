//
//  UIImage+Conversion.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/26.
//

import UIKit

extension UIImage {
    func toString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
