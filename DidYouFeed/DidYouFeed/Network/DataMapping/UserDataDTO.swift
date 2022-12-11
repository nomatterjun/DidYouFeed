//
//  UserDataDTO.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/10.
//

import Foundation

struct UserDataDTO: Codable {
    private let uid: String
    private let nickname: String
    private let image: String
    private let family: [String]
    
    private enum CodingKeys: String, CodingKey {
        case uid, nickname, image, family
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.image = try container.decode(String.self, forKey: .image)
        self.family = try container.decode([String].self, forKey: .family)
    }
    
    func toDomain() -> UserData {
        return UserData(
            uid: self.uid,
            nickname: self.nickname,
            image: self.image,
            family: self.family
        )
    }
}
