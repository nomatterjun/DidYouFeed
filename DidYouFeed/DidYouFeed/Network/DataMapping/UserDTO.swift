//
//  UserDTO.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/10.
//

import Foundation

struct UserDTO: Codable {
    private let uID: StringValue
    private let name: StringValue
    private let image: StringValue
    
    private enum RootKey: String, CodingKey {
        case fields
    }
    
    private enum CodingKeys: String, CodingKey {
        case uID, name, image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let fieldContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .fields)
        self.uID = try fieldContainer.decode(StringValue.self, forKey: .uID)
        self.name = try fieldContainer.decode(StringValue.self, forKey: .name)
        self.image = try fieldContainer.decode(StringValue.self, forKey: .image)
    }
    
    init(user: User) {
        self.uID = StringValue(value: user.uID)
        self.name = StringValue(value: user.name)
        self.image = StringValue(value: user.image ?? "")
    }
    
    func toDomain() -> User {
        return User(
            name: self.name.value,
            image: self.image.value
        )
    }
}
