//
//  AddPetReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/22.
//

import Foundation

import ReactorKit

final class AddPetReactor: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: OnboardCoordinator?
    
    enum Action {
        case viewDidLoad
        case updateNameTextField(String)
        case confirmButtonTap
    }
    
    enum Mutation {
        case updateDataSource
        case updateName(String)
        case addPetToFamily
    }
    
    struct State {
        var speciesSection = SpeciesSection.SpeciesModel(
            model: 0,
            items: []
        )
        var name = ""
    }
    
    var initialState: State
    
    // MARK: - Initializer
    
    init(coordinator: OnboardCoordinator) {
        self.coordinator = coordinator
        self.initialState = State()
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.just(.updateDataSource)
        case .updateNameTextField(let name):
            return Observable.just(.updateName(name))
        case .confirmButtonTap:
            return Observable.just(.addPetToFamily)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateDataSource:
            let species = MockService.standard.getSpeciesMock()
            let items = species.map(SpeciesSection.SpeciesItem.specified)
            let sectionModel = SpeciesSection.SpeciesModel(model: 0, items: items)
            newState.speciesSection = sectionModel
        case .updateName(let name):
            newState.name = name
        case .addPetToFamily:
            print(currentState.name)
        }
        return newState
    }
}
