//
//  Family.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation

struct Family {
    let fID: String
    let members: [String]
    let pets: [String]
    
    init(
        fID: String = "",
        members: [String] = [],
        pets: [String] = []
    ) {
        self.fID = fID
        self.members = members
        self.pets = pets
    }
}
