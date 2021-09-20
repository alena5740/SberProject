//
//  GetFriendsService.swift
//  SberProject
//
//  Created by Алена on 10.09.2021.
//

import Foundation

// Протокол для загрузки списка друзей
protocol GetFriendsServiceProtocol {
    func loadFriends(completion: @escaping (Result<Response, Error>) -> Void)
}

// Сервис для загрузки списка друзей
final class GetFriendsService: GetFriendsServiceProtocol {
    
    let networkService = NetService()
    let networkHelper = NetworkHelper()
    
    func loadFriends(completion: @escaping (Result<Response, Error>) -> Void) {
        let parametres = ["fields": "photo_50",
                          "access_token": UserDefaultsService.token!,
                          "v": "5.131"]
        
        let request = networkHelper.configureApi(parametrs: parametres, method: "/method/friends.get")
        guard let request = request else { return }
        networkService.baseRequest(request: request, completion: completion)
    }
}
