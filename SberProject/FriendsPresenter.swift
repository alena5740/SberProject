//
//  FriendsPresenter.swift
//  SberProject
//
//  Created by Алена on 22.08.2021.
//

import UIKit

// Протокол презентера экрана друзей
protocol FriendsPresenterProtocol: AnyObject {
    func getModel(success: @escaping () -> Void)
    var arrayModel: [FriendsModel?] { get }
}

// Презентер экрана друзей
final class FriendsPresenter: FriendsPresenterProtocol {
    var arrayModel: [FriendsModel?] = []
    let service: GetFriendsServiceProtocol
    
    init(friendService: GetFriendsServiceProtocol) {
        self.service = friendService
    }
    
    func getModel(success: @escaping () -> Void) {
        service.loadFriends { result in
            switch result {
            case let .success(friends):
                let models = friends.response.items
                models.forEach { model in
                    let friend = FriendsModel(name: model.firstname,
                                              surname: model.lastname,
                                              photoAvatar: model.photo,
                                              id: model.id)
                    self.arrayModel.append(friend)
                    success()
                }
                success()
            case .failure(_):
                print("Ошибка получения данных списка друзей")
            }
        }
    }
}
