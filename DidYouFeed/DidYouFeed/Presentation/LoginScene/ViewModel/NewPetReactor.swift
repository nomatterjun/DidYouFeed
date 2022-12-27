//
//  NewPetReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/22.
//

import OSLog
import UIKit

import ReactorKit

final class NewPetReactor: Reactor {
    typealias Validate = ValidationState.PetName
    
    // MARK: - Properties
    
    weak var coordinator: NewPetCoordinator?
    
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
        case validatePetName(Validate)
    }
    
    struct State {
        var speciesSection = SpeciesSection.SpeciesModel(
            model: 0,
            items: []
        )
        var pet: Pet = Pet()
        var name: String = ""
        var petImage: UIImage = UIImage(named: "PetIconPlaceholder")!
        var validatePetName: Validate = .empty
    }
    
    var initialState: State
    
    // MARK: - Initializer
    
    init(coordinator: NewPetCoordinator) {
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
            let petNameValidate = self.validate(name: name)
            switch petNameValidate {
            case .success, .empty:
                var pet = currentState.pet
                pet.name = name
                return Observable.concat([
                    Observable.just(.validatePetName(petNameValidate)),
                    Observable.just(.updatePetName(name)),
                    Observable.just(.updatePet(pet))
                ])
            case .invalid, .upperboundViolated:
                return Observable.just(.validatePetName(petNameValidate))
            }
            
        case .updatePetIcon(let image):
            var pet = currentState.pet
            pet.image = image.toString()
            return Observable.concat([
                Observable.just(.updatePetImage(image)),
                Observable.just(.updatePet(pet))
            ])
            
        case .petImageButtonTap:
            if currentState.pet.image == nil {
                os_log(.info, "Picture for pet is not set yet.")
            }
            self.coordinator?.presentImagePicker()
            return Observable<Mutation>.empty()
            
        case .confirmButtonTap:
            AppData.petsData.append(currentState.pet)
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
            
        case .validatePetName(let validate):
            newState.validatePetName = validate
        }
        return newState
    }
}

extension NewPetReactor: NameValidate {
    func validate(name: String) -> Validate {
        guard !name.isEmpty else {
            return .empty
        }
        guard name.count <= 20 else {
            return .upperboundViolated
        }
        guard name.range(of: "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]*$", options: .regularExpression) != nil else {
            return .invalid
        }
        guard name.range(of: "^[\\S]*$", options: .regularExpression) != nil else {
            return .invalid
        }
        return .success
    }
}