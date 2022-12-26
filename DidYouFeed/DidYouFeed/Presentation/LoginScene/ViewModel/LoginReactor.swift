//
//  LoginReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import Foundation
import OSLog

import ReactorKit

final class LoginReactor: Reactor {
    typealias Validate = ValidationState.Nickname
    
    // MARK: - Properties
    
    weak var coordinator: OnboardCoordinator?
    var initialState: State
    
    enum Action {
        case updateNickname(String)
        case confirmButtonTap
    }
    
    enum Mutation {
        case updateNickname(String)
        case validateNickname(Validate)
    }
    
    struct State {
        var username: String
        var validateNickname: Validate
        
        init(username: String) {
            self.username = username
            self.validateNickname = .empty
        }
    }
    
    // MARK: - Initializer
    
    init(coordinator: OnboardCoordinator) {
        self.coordinator = coordinator
        self.initialState = State(username: "")
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateNickname(let nickname):
            let nicknameValidate = self.validate(nickname: nickname)
            return Observable.concat([
                Observable.just(.validateNickname(nicknameValidate)),
                Observable.just(.updateNickname(nickname))
            ])
            
        case .confirmButtonTap:
            AppData.userData.name = currentState.username
            os_log(.info, "Set user's name as \(AppData.userData.name)")
            self.coordinator?.showJoinFlow(for: currentState.username)
            return Observable<Mutation>.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .updateNickname(let nickname):
            newState.username = nickname
            
        case .validateNickname(let nicknameValidate):
            newState.validateNickname = nicknameValidate
        }
        return newState
    }
}

private extension LoginReactor {
    func validate(nickname: String) -> Validate {
        guard !nickname.isEmpty else {
            return .empty
        }
        guard nickname.count >= 3 else {
            return .lowerboundViolated
        }
        guard nickname.count <= 20 else {
            return .upperboundViolated
        }
        guard nickname.range(of: "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]*$", options: .regularExpression) != nil else {
            return .invalid
        }
        guard nickname.range(of: "^[\\S]*$", options: .regularExpression) != nil else {
            return .invalid
        }
        return .success
    }
}
