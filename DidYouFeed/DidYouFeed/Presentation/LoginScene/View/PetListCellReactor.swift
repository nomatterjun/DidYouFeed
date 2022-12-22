//
//  PetListCellReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/16.
//

import Foundation

import ReactorKit

final class PetListCellReactor: Reactor {
    
    // MARK: - Properties
    
    var initialState: Pet
    
    typealias Action = NoAction
    
    // MARK: - Initializer
    
    init(pet: Pet) {
        self.initialState = pet
    }
}

