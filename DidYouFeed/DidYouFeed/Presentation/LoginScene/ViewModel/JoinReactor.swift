//
//  JoinReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/14.
//

import Foundation

import ReactorKit

final class JoinReactor: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: LoginCoordinator?
    var initialState: State
    
    enum Action {
        case newButtonTap
    }
    
    enum Mutation {
        case createNewFamily
    }
    
    struct State {
        
    }
    
    // MARK: - Initializer
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.initialState = State()
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .newButtonTap:
            return Observable.just(.createNewFamily)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .createNewFamily:
            self.coordinator?.showNewFamilyFlow()
        }
        return newState
    }
}
