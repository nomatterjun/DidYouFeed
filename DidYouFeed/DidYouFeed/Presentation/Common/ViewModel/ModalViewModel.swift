//
//  ModalViewModel.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/06.
//

import Foundation

import ReactorKit

final class ModalViewModel: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: ModalViewCoordinator?
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState = State()
    
    // MARK: - Initializer
    
    init(coordinator: ModalViewCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Functions
    
    
}
