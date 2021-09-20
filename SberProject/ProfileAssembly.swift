//
//  ProfileAssembly.swift
//  SberProject
//
//  Created by Алена on 19.08.2021.
//

import UIKit

// Сборщик модуля профиль
final class ProfileAssembly {
    
    func assemblyProfile(userID: String) -> UITabBarController {
        let profileViewController = ProfileViewController()
        let friendsViewController = FriendsViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        let friendsNavigationController = UINavigationController(rootViewController: friendsViewController)
        let profilePresenter = ProfilePresenter(profileService: GetProfileService(), photoService: GetPhotoService())
        profilePresenter.viewDelegate = profileViewController
        let friendsPresenter = FriendsPresenter(friendService: GetFriendsService())
        profileViewController.presenter = profilePresenter
        friendsViewController.friendsPresenter = friendsPresenter
        
        profilePresenter.userID = userID
                
        profileNavigationController.tabBarItem.title = "Профиль"
        profileNavigationController.tabBarItem.image = UIImage(named: "home.png")
        friendsNavigationController.tabBarItem.title = "Мои друзья"
        friendsNavigationController.tabBarItem.image = UIImage(named: "friends.png")
        
        let controllersArray = [profileNavigationController, friendsNavigationController]
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = controllersArray
        return tabBar
    }
}
