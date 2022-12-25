//
//  PetDTO.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/26.
//

import Foundation

struct PetDTO: Codable {
    private let pID: StringValue
    private let name: StringValue
    private let image: StringValue
    
    private enum RootKey: String, CodingKey {
        case fields
    }
    
    private enum CodingKeys: String, CodingKey {
        case pID, name, image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let fieldContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .fields)
        self.pID = try fieldContainer.decode(StringValue.self, forKey: .pID)
        self.name = try fieldContainer.decode(StringValue.self, forKey: .name)
        self.image = try fieldContainer.decode(StringValue.self, forKey: .image)
    }
    
    init(pet: Pet) {
        self.pID = StringValue(value: pet.pID)
        self.name = StringValue(value: pet.name)
        self.image = StringValue(value: pet.image ?? "")
    }
}
