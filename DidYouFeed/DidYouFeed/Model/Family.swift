//
//  Family.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation
import OrderedCollections

struct Family: Codable {
    let fID: String
    var name: String
    var members: [String] {
        didSet {
            self.members = Array(OrderedSet(oldValue))
        }
    }
    var pets: [String] {
        didSet {
            self.pets = Array(OrderedSet(oldValue))
        }
    }
    
    init(
        fID: String = UUID().uuidString,
        name: String = "",
        members: [String] = [],
        pets: [String] = []
    ) {
        self.fID = fID
        self.name = name
        self.members = members
        self.pets = pets
    }
}
