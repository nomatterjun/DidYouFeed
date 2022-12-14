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
        case updateNickname(String)
        case confirmButtonTap
    }
    
    enum Mutation {
        case updateNickname(String)
        case validateNickname(NicknameValidationState)
        case confirmNickname
    }
    
    struct State {
        var nickname: String
        var validateNickname: NicknameValidationState
        
        init(nickname: String) {
            self.nickname = nickname
            self.validateNickname = .empty
        }
    }
    
    // MARK: - Initializer
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.initialState = State(nickname: "")
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateNickname(nickname):
            let nicknameValidate = self.validate(nickname: nickname)
            return Observable.concat([
                Observable.just(.validateNickname(nicknameValidate)),
                Observable.just(.updateNickname(nickname))
            ])
        case .confirmButtonTap:
            return Observable.just(.confirmNickname)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .updateNickname(nickname):
            newState.nickname = nickname
        case let .validateNickname(nicknameValidate):
            newState.validateNickname = nicknameValidate
        case .confirmNickname:
            self.coordinator?.showJoinFlow(for: currentState.nickname)
        }
        return newState
    }
}

private extension LoginReactor {
    func validate(nickname: String) -> NicknameValidationState {
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
