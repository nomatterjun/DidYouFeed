//
//  FamilyNameValidationState.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/15.
//

import Foundation

enum FamilyNameValidationState {
    case empty
    case lowerboundViolated
    case upperboundViolated
    case success
    
    var description: String {
        switch self {
        case .empty, .success:
            return ""
        case .lowerboundViolated:
            return "최소 3자 이상 입력해주세요."
        case .upperboundViolated:
            return "최대 20자까지만 가능합니다."
        }
    }
}
