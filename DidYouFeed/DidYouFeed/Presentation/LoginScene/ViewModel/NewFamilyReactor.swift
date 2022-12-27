//
//  NewFamilyReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/15.
//

import Foundation

import ReactorKit
import RxCocoa

final class NewFamilyReactor: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: OnboardCoordinator?
    var initialState: State
    
    enum Action {
        case viewDidLoad
        case updateFamilyName(String)
        case addPetButtonTap
        case confirmButtonTap
    }
    
    enum Mutation {
        case updateFamilyName(String)
        case updateDataSource
    }
    
    struct State {
        var familyName: String = ""
        var petListSection = PetListSection.PetListSectionModel(
            model: 0,
            items: []
        )
    }
    
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
            
        case .updateFamilyName(let familyName):
            let familyNameValidate = self.validate(familyName: familyName)
            return Observable.just(.updateFamilyName(familyName))
            
        case .addPetButtonTap:
            self.coordinator?.showAddPetFlow()
            return Observable<Mutation>.empty()
            
        case .confirmButtonTap:
            AppData.familyData.name = currentState.familyName
            AppData.familyData.members.append(AppData.userData.uID)
            print(AppData.userData)
            AppData.familyData.pets = AppData.petsData.map { $0.pID }
            print(AppData.familyData)
            print(AppData.petsData.map {$0.name})
            return Observable<Mutation>.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateFamilyName(let familyName):
            newState.familyName = familyName
            
        case .updateDataSource:
            let pets = MockService.standard.getPetMock()
            let items = pets.map(PetListSection.PetItem.standard)
            let sectionModel = PetListSection.PetListSectionModel(model: 0, items: items)
            newState.petListSection = sectionModel
        }
        return newState
    }
}

// MARK: - Private Functions

private extension NewFamilyReactor {
    
    func validate(familyName: String) -> FamilyNameValidationState {
        guard !familyName.isEmpty else {
            return .empty
        }
        guard familyName.count >= 3 else {
            return .lowerboundViolated
        }
        guard familyName.count <= 20 else {
            return .upperboundViolated
        }
        return .success
    }
    
}
