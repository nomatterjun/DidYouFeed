//
//  NameValidate.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/26.
//

import Foundation

protocol NameValidate: AnyObject {
    associatedtype T = ValidationState
    
    func validate(name: String) -> T
}
