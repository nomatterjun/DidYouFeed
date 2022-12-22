//
//  Species.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/20.
//

enum Species: CaseIterable {
    case dog, cat, turtle, fish, hamster
    
    var emoji: String {
        switch self {
        case .dog:
            return "🐶"
        case .cat:
            return "🐱"
        case .turtle:
            return "🐢"
        case .fish:
            return "🐠"
        case .hamster:
            return "🐹"
        }
    }
}
