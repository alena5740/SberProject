//
//  FriendsModel.swift
//  SberProject
//
//  Created by Алена on 22.08.2021.
//

import UIKit

// Модель друзей
struct FriendsModel {
    let name: String?
    let surname: String?
    let photoAvatar: String?
    let id: Int?
}

struct Response: Codable {
    var response: ResponseInfo
}

struct ResponseInfo: Codable {
    var count: Int
    var items: [User]
}

struct User: Codable {
    let id: Int?
    let firstname: String?
    let lastname: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstname = "first_name"
        case lastname = "last_name"
        case photo = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.firstname = try? container.decode(String.self, forKey: .firstname)
        self.lastname = try? container.decode(String.self, forKey: .lastname)
        self.photo = try? container.decode(String.self, forKey: .photo)
   }
}
