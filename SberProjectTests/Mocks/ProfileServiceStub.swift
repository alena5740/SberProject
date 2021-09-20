//
//  ProfileServiceStub.swift
//  SberProjectTests
//
//  Created by Алена on 16.09.2021.
//

@testable import SberProject
import UIKit

final class ProfileServiceStub: GetProfileServiceProtocol {
    
    var loadProfileStub: ((String, (Result<ProfileModelListed, Error>) -> Void) -> Void)?
    
    func loadProfile(userID: String, completion: @escaping (Result<ProfileModelListed, Error>) -> Void) {
        loadProfileStub?(userID, completion)
    }
}
