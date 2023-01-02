//
//  MockService.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/09.
//

import Foundation

import RxSwift

struct MockService {
    
    // MARK: - Singleton
    
    static let standard = MockService()
    
    // MARK: - Initializer
    
    private init() {
        
    }
    
    func getTaskMock() -> Observable<[Task]> {
        return .just((1...9).map {
            Task(
                title: "title\($0)",
                isDone: false
            )
        })
    }
    
    func getPetMock() -> [PetListSection] {
        let one = PetListSectionItem.standard(PetListCellReactor(pet: Pet(name: "초롬1")))
        let two = PetListSectionItem.standard(PetListCellReactor(pet: Pet(name: "초롬2")))
        let three = PetListSectionItem.standard(PetListCellReactor(pet: Pet(name: "초롬3")))
        let itemsInSection = [one, two, three]
        
        let petListSection = PetListSection(
            original: PetListSection(original: .standard(itemsInSection), items: itemsInSection),
            items: itemsInSection
        )
        return [petListSection]
    }
    
    func getSpeciesMock() -> [String] {
        Species.allCases.map { $0.emoji }
    }
}
