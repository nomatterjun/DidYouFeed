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
        case updatePet(Pet)
        case updatePetName(String)
        case updatePetImage(UIImage)
    }
    
    struct State {
        var speciesSection = SpeciesSection.SpeciesModel(
            model: 0,
            items: []
        )
        var pet: Pet = Pet()
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
            var pet = currentState.pet
            pet.name = name
            return Observable.concat([
                Observable.just(.updatePetName(name)),
                Observable.just(.updatePet(pet))
            ])
            
        case .updatePetIcon(let image):
            var pet = currentState.pet
            pet.image = image.toString()
            return Observable.concat([
                Observable.just(.updatePetImage(image)),
                Observable.just(.updatePet(pet))
            ])
            
        case .petImageButtonTap:
            if currentState.pet.image == nil {
                print("Picture for pet is not set yet.")
            }
            self.coordinator?.presentImagePicker()
            return Observable<Mutation>.empty()
            
        case .confirmButtonTap:
            self.coordinator?.finish()
            return Observable<Mutation>.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateDataSource(let sectionModel):
            newState.speciesSection = sectionModel

        case .updatePet(let pet):
            newState.pet = pet
            
        case .updatePetName(let name):
            newState.name = name
            
        case .updatePetImage(let image):
            newState.petImage = image
        }
        return newState
    }
}
