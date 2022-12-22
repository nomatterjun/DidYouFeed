//
//  FamilyDTO.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation

struct FamilyDTO: Codable {
    private let fID: StringValue
    private let name: StringValue
    private let members: ArrayValue<StringValue>
    private let pets: ArrayValue<StringValue>
    
    private enum RootKey: String, CodingKey {
        case fields
    }
    
    private enum FieldKeys: String, CodingKey {
        case fID, name, members, pets
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let fieldContainer = try container.nestedContainer(keyedBy: FieldKeys.self, forKey: .fields)
        self.fID = try fieldContainer.decode(StringValue.self, forKey: .fID)
        self.name = try fieldContainer.decode(StringValue.self, forKey: .name)
        self.members = try fieldContainer.decode(ArrayValue<StringValue>.self, forKey: .members)
        self.pets = try fieldContainer.decode(ArrayValue<StringValue>.self, forKey: .pets)
    }
    
    init(family: Family) {
        self.fID = StringValue(value: family.fID)
        self.name = StringValue(value: family.name)
        self.members = ArrayValue(values: family.members.map({ StringValue(value: $0) }))
        self.pets = ArrayValue(values: family.pets.map({ StringValue(value: $0) }))
    }
    
    func toDomain() -> Family {
        return Family(
            fID: self.fID.value,
            name: self.name.value,
            members: self.members.arrayValue["values"]?.compactMap { $0.value } ?? [],
            pets: self.pets.arrayValue["values"]?.compactMap { $0.value } ?? []
        )
    }
}
