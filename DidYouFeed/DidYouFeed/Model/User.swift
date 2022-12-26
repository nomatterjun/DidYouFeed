//
//  User.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import Foundation

struct User: Codable {
    var uID: String
    var name: String
    var image: String?
    
    init(
        uID: String = UUID().uuidString,
        name: String = "",
        image: String? = nil
    ) {
        self.uID = uID
        self.name = name
        self.image = image
    }
}
