//
//  NetService.swift
//  SberProject
//
//  Created by Алена on 10.09.2021.
//

import Foundation

// Сервис для работы с сетью
final class NetService {
    private let session = URLSession(configuration: .default)
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    func baseRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let handler: Handler = { [weak self] rawData, response, taskError in
            guard let self = self else { return }
            if let error = taskError {
                completion(.failure(error))
                return
            }
            guard let data = rawData else {
                completion(.failure(NetworkServiceError.dataIsNil))
                return
            }
            do {
                let decodedObject = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        session.dataTask(with: request, completionHandler: handler).resume()
    }
}

extension NetService {
    enum NetworkServiceError: Error {
        case wrongURL
        case decodable
        case dataIsNil
        case unknown
        case wrongPage
    }
    
    private enum Constants {
        static let indexPageMultiplier = 100
    }
}
