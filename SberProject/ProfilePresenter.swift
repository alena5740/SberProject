//
//  ProfilePresenter.swift
//  SberProject
//
//  Created by Алена on 22.08.2021.
//

import UIKit

// Протокол презентера экрана профиля
protocol ProfilePresenterProtocol: AnyObject {
    func getData(userID: String)
    var model: ProfileModel? { get }
    var userID: String { get }
    var modelPhotosLargeArray: [PhotoLargeModel] { get }
    var modelPhotosSmallArray: [PhotoSmallModel] { get }
    func getPhotos(userID: String)
}

// Протокол исходящих событий от view
protocol ProfileViewOutputProtocol: AnyObject {
    func updateView()
    func hideLoadingView(isHidden: Bool)
}

// Презентер экрана профиля
final class ProfilePresenter: ProfilePresenterProtocol {
    var userID = ""
    var model: ProfileModel?
    var modelPhotosLargeArray: [PhotoLargeModel] = []
    var modelPhotosSmallArray: [PhotoSmallModel] = []
    weak var viewDelegate: ProfileViewOutputProtocol?
    private let profileService: GetProfileServiceProtocol
    private let photoService: GetPhotoServiceProtocol
    
    init(profileService: GetProfileServiceProtocol,
         photoService: GetPhotoServiceProtocol) {
        self.profileService = profileService
        self.photoService = photoService
    }
    
    func getData(userID: String) {
        profileService.loadProfile(userID: userID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(profile):
                let model = profile.response.first
                self.model = ProfileModel(name: model?.firstname, surname: model?.lastname, city: model?.city, dateOfBirth: model?.bdate, photoAvatar: model?.photoMax)
                self.viewDelegate?.updateView()
            case .failure(_):
                print("Ошибка получения данных пользователя")
            }
        }
    }
    
    func getPhotos(userID: String) {
        viewDelegate?.hideLoadingView(isHidden: false)
        
        photoService.loadAlbum(userID: userID) { result in
            switch result {
            case let .success(photos):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.viewDelegate?.hideLoadingView(isHidden: true)
                }
                let items = photos.response.items
                
                    items.forEach { model in
                        model.sizes.forEach { photo in
                            if photo.type == "p" {
                                let modelSmall = PhotoSmallModel(smallPhotoURL: photo)
                                self.modelPhotosSmallArray.append(modelSmall)
                            }
                            if photo.type == "r" {
                                let modelLarge = PhotoLargeModel(largePhotoURL: photo)
                                self.modelPhotosLargeArray.append(modelLarge)

                            }
                        }
                    }
                self.viewDelegate?.updateView()
            case .failure(_):
                print("Ошибка получения фотографий")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.viewDelegate?.hideLoadingView(isHidden: true)
                }
            }
        }
    }
}



