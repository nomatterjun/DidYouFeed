//
//  Family.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation

struct Family {
    let fID: String
    let name: String
    let members: [String]
    let pets: [String]
    
    init(
        name: String = "",
        members: [String] = [],
        pets: [String] = []
    ) {
        self.fID = UUID().uuidString
        self.name = name
        self.members = members
        self.pets = pets
    }
    
    init(
        fID: String,
        name: String,
        members: [String],
        pets: [String]
    ) {
        self.fID = fID
        self.name = name
        self.members = members
        self.pets = pets
    }
}
