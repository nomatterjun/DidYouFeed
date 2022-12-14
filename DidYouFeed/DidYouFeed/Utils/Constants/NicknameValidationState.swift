//
//  NicknameValidationState.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation

enum NicknameValidationState {
    case empty
    case lowerboundViolated
    case upperboundViolated
    case invalid
    case success
    
    var description: String {
        switch self {
        case .empty, .success:
            return ""
        case .lowerboundViolated:
            return "최소 3자 이상 입력해주세요."
        case .upperboundViolated:
            return "최대 20자까지만 가능합니다."
        case .invalid:
            return "특수문자는 사용할 수 없습니다."
        }
    }
}
