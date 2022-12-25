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
        case showAddPetView
        case confirmFamilyName
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
            
        case .confirmButtonTap:
            return Observable.just(.confirmFamilyName)
            
        case .addPetButtonTap:
            return Observable.just(.showAddPetView)
            
        case let .updateFamilyName(familyName):
            let familyNameValidate = self.validate(familyName: familyName)
            return Observable.just(.updateFamilyName(familyName))
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case let .updateFamilyName(familyName):
            newState.familyName = familyName
            
        case .updateDataSource:
            let pets = MockService.standard.getPetMock()
            let items = pets.map(PetListSection.PetItem.standard)
            let sectionModel = PetListSection.PetListSectionModel(model: 0, items: items)
            newState.petListSection = sectionModel
        
        case .showAddPetView:
            self.coordinator?.showAddPetFlow()
            
        case .confirmFamilyName: // TODO: 데이터 바인딩
            FirestoreService.standard.save(
                family: Family(
                    name: self.currentState.familyName,
                    members: ["Mem"],
                    pets: [Pet()]
                )
            )
            
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
