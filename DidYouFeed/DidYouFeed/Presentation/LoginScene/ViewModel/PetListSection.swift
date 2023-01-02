//
//  PetListSection.swift
//  DidYouFeed
//
//  Created by 이창준 on 2023/01/03.
//

import RxDataSources

enum PetListSection {
    case standard([PetListSectionItem])
}

enum PetListSectionItem {
    case standard(PetListCellReactor)
}

extension PetListSection: SectionModelType {
    var items: [PetListSectionItem] {
        switch self {
        case .standard(let items):
            return items
        }
    }
    
    init(original: PetListSection, items: [PetListSectionItem]) {
        switch original {
        case .standard:
            self = .standard(items)
        }
    }
}
