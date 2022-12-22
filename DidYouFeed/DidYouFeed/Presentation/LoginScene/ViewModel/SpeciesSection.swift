//
//  SpeciesSection.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/21.
//

import RxDataSources

struct SpeciesSection {
    typealias SpeciesModel = SectionModel<Int, SpeciesItem>
    
    enum SpeciesItem: Equatable {
        case specified(String)
    }
}
