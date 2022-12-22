//
//  CGRect+One.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/16.
//

import Foundation

extension CGRect {
    /// A rectengle whose origin is zero but size is 1 squared.
    public static var one: CGRect {
        CGRect(origin: .zero, size: CGSize(width: 1.0, height: 1.0))
    }
}
