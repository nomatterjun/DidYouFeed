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
        willSet {
            self.members = Array(OrderedSet(newValue))
        }
    }
    var pets: [String] {
        willSet {
            self.pets = Array(OrderedSet(newValue))
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
