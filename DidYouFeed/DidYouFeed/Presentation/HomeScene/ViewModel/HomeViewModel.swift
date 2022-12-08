//
//  HomeViewReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import Foundation

import ReactorKit

final class HomeViewModel: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: HomeCoordinator?
    
    enum Action {
        case buttonTap
    }
    
    enum Mutation {
        case buttonTap
    }
    
    struct State {
        
    }
    
    var initialState = State()
    
    // MARK: - Initializer
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .buttonTap:
            return .just(.buttonTap)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .buttonTap:
            print("Tapped")
            return state
        }
    }
    
}
