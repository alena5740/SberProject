//
//  AlbumList.swift
//  SberProject
//
//  Created by Алена on 08.09.2021.
//

import UIKit

// Модель фотографии в большом расширении для фоторедактора
struct PhotoSmallModel {
    let smallPhotoURL: SizesModel
}

// Модель фотографии в маленьком расширении для профиля
struct PhotoLargeModel {
    let largePhotoURL: SizesModel
}

struct AlbumList: Decodable {
    let response: PhotoAlmbumResponse
}

struct PhotoAlmbumResponse: Decodable {
    let count: Int?
    let items: [AlbumModel]
}

struct AlbumModel: Decodable {
    let sizes: [SizesModel]
}

struct SizesModel: Codable {
    let url: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case url
        case type
    }

    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)

        self.url = try? container.decode(String.self, forKey: .url)
        self.type = try? container.decode(String.self, forKey: .type)
   }
}
