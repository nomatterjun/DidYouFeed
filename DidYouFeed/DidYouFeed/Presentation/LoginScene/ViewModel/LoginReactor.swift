//
//  LoginReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import Foundation

import ReactorKit

final class LoginReactor: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: LoginCoordinator?
    var initialState: State
    
    enum Action {
        
    }
    
    struct State {
        
    }
    
    // MARK: - Initializer
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.initialState = State()
    }
    
    // MARK: - Functions
    
//    func mutate(action: Action) -> Observable<Action> {
//        <#code#>
//    }
}
