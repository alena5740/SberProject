//
//  AuthService.swift
//  SberProject
//
//  Created by Алена on 12.08.2021.
//

import Foundation

// Сервис для авторизации
final class AuthService {
    func getToken(string: String) -> String {
        if string.contains("access_token=") {
            let result = string.split(separator: "=")
            let token = result[1].split(separator: "&")
            return String(token[0])
        }
        return ""
     }
    
    func authorization(token: String, success: () -> Void) {
        if !token.isEmpty {
            success()
            return
        }
    }
}

