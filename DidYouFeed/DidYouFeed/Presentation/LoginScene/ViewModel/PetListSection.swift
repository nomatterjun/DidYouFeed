//
//  PetListSection.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/17.
//

import RxDataSources

struct PetListSection {
    typealias PetListSectionModel = SectionModel<Int, PetItem>
    
    enum PetItem: Equatable {
        case standard(Pet)
    }
}
