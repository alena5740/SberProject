//
//  GetProfileService.swift
//  SberProject
//
//  Created by Алена on 10.09.2021.
//

import Foundation

// Протокол для загрузки профиля пользователя
protocol GetProfileServiceProtocol {
    func loadProfile(userID: String, completion: @escaping (Result<ProfileModelListed, Error>) -> Void)
}

// Сервис для загрузки профиля пользователя
final class GetProfileService: GetProfileServiceProtocol {
    
    let networkService = NetService()
    let networkHelper = NetworkHelper()
    
    func loadProfile(userID: String, completion: @escaping (Result<ProfileModelListed, Error>) -> Void) {
        var parametres = ["fields": "bdate,photo_max,city",
                          "access_token": UserDefaultsService.token!,
                          "v": "5.131"]
        
        if !userID.isEmpty {
            parametres["user_ids"] = userID
        }
        
        let request = networkHelper.configureApi(parametrs: parametres, method: "/method/users.get")
        guard let request = request else { return }
        networkService.baseRequest(request: request, completion: completion)
    }
}
