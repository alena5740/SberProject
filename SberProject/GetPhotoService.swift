//
//  GetPhotoService.swift
//  SberProject
//
//  Created by Алена on 10.09.2021.
//

import Foundation

// Протокол для загрузки фотографий
protocol GetPhotoServiceProtocol {
    func loadAlbum(userID: String, completion: @escaping (Result<AlbumList, Error>) -> Void)
}

// Сервис для загрузки фотографий
final class GetPhotoService: GetPhotoServiceProtocol {
    
    let networkService = NetService()
    let networkHelper = NetworkHelper()
    
    func loadAlbum(userID: String, completion: @escaping (Result<AlbumList, Error>) -> Void) {
        var parametres = ["count": "200",
                          "access_token": UserDefaultsService.token!,
                          "v": "5.131"]
        
        if !userID.isEmpty {
            parametres["owner_id"] = userID
        }
        
        let request = networkHelper.configureApi(parametrs: parametres, method: "/method/photos.getAll")
        guard let request = request else { return }
        networkService.baseRequest(request: request, completion: completion)
    }
}
