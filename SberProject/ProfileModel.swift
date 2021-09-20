//
//  ProfileModel.swift
//  SberProject
//
//  Created by Алена on 10.09.2021.
//

import UIKit

// Модель профиля
struct ProfileModel {
    let name: String?
    let surname: String?
    let city: String?
    let dateOfBirth: String?
    let photoAvatar: String?
}

struct ProfileModelListed: Codable {
    let response: [ProfileModelList]
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}

struct ProfileModelList: Codable {
    let id: String?
    let firstname: String?
    let lastname: String?
    let bdate: String?
    let photoMax: String?
    let city: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstname = "first_name"
        case lastname = "last_name"
        case bdate
        case photoMax = "photo_max"
        case city
    }
    
    enum CityKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(String.self, forKey: .id)
        self.firstname = try? container.decode(String.self, forKey: .firstname)
        self.lastname = try? container.decode(String.self, forKey: .lastname)
        self.bdate = try? container.decode(String.self, forKey: .bdate)
        self.photoMax = try? container.decode(String.self, forKey: .photoMax)
        let сityContainer = try? container.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        self.city = try? сityContainer?.decode(String.self, forKey: .title)
   }
}
