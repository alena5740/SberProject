//
//  UserDefaultsService.swift
//  SberProject
//
//  Created by Алена on 19.08.2021.
//

import Foundation

// Сервис для работы с UserDefaults
final class UserDefaultsService {
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        } set {
            let defaults = UserDefaults.standard
            if let token = newValue {
                defaults.set(token, forKey: "token")
            } else {
                defaults.removeObject(forKey: "token")
            }
            
        }
    }
}
