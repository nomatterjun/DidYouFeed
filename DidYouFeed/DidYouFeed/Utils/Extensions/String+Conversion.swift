//
//  String+Conversion.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/26.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
}
