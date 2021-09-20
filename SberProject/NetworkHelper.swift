//
//  NetworkHelper.swift
//  SberProject
//
//  Created by Алена on 10.09.2021.
//

import Foundation

// Сервис для сетевого слоя
final class NetworkHelper {
    let baseURL = "https://api.vk.com/method/"
    
    func configureApi(parametrs: [String: String] = [:], method: String) -> URLRequest? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = parametrs.compactMap { URLQueryItem(name: $0, value: $1) }
        components?.path = method
        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
