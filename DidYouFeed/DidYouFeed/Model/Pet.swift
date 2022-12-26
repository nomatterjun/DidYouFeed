//
//  Pet.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/16.
//

import Foundation

struct Pet: Equatable, Codable {
    var pID: String
    var name: String
    var image: String?
    
    init(
        pID: String = UUID().uuidString,
        name: String = "",
        image: String? = nil
    ) {
        self.pID = pID
        self.name = name
        self.image = image
    }
}
