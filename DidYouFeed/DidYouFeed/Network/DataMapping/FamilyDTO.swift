//
//  FamilyDTO.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation

struct FamilyDTO: Codable {
    private let members: ArrayValue<StringValue>
    private let pets: ArrayValue<StringValue>
    
    private enum RootKey: String, CodingKey {
        case fields
    }
    
    private enum FieldKeys: String, CodingKey {
        case members
        case pets
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let fieldContainer = try container.nestedContainer(keyedBy: FieldKeys.self, forKey: .fields)
        self.members = try fieldContainer.decode(ArrayValue<StringValue>.self, forKey: .members)
        self.pets = try fieldContainer.decode(ArrayValue<StringValue>.self, forKey: .pets)
    }
    
//    func toDomain() -> Family {
//        return Famil
//    }
}
