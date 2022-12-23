//
//  AddPetReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/22.
//

import UIKit

import ReactorKit

final class AddPetReactor: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: AddPetCoordinator?
    
    enum Action {
        case viewDidLoad
        case updateNameTextField(String)
        case updatePetIcon(UIImage)
        case petImageButtonTap
        case confirmButtonTap
    }
    
    enum Mutation {
        case updateDataSource(SpeciesSection.SpeciesModel)
        case updateName(String)
        case updatePetIcon(UIImage)
        case addPetToFamily
    }
    
    struct State {
        var speciesSection = SpeciesSection.SpeciesModel(
            model: 0,
            items: []
        )
        var name: String = ""
        var petImage: UIImage = UIImage(named: "PetIconPlaceholder")!
    }
    
    var initialState: State
    
    // MARK: - Initializer
    
    init(coordinator: AddPetCoordinator) {
        self.coordinator = coordinator
        self.initialState = State()
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let species = MockService.standard.getSpeciesMock()
            let items = species.map(SpeciesSection.SpeciesItem.specified)
            let sectionModel = SpeciesSection.SpeciesModel(model: 0, items: items)
            return Observable.just(.updateDataSource(sectionModel))
            
        case .updateNameTextField(let name):
            return Observable.just(.updateName(name))
            
        case .updatePetIcon(let image):
            return Observable.just(.updatePetIcon(image))
            
        case .petImageButtonTap:
            self.coordinator?.presentImagePicker()
            return Observable<Mutation>.empty()
            
        case .confirmButtonTap:
            return Observable.just(.addPetToFamily)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateDataSource(let sectionModel):
            newState.speciesSection = sectionModel
            
        case .updateName(let name):
            newState.name = name
            
        case .updatePetIcon(let image):
            newState.petImage = image
            
        case .addPetToFamily:
            print(currentState.name)
        }
        return newState
    }
}
