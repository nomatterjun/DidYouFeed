//
//  UserData.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import Foundation

struct UserData {
    let uid: String
    let nickname: String
    let image: String
    let family: [String]
    
    init(
        uid: String = "",
        nickname: String = "",
        image: String = "",
        family: [String] = []
    ) {
        self.uid = UUID().uuidString
        self.nickname = nickname
        self.image = image
        self.family = family
    }
}
