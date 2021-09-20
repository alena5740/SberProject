//
//  PhotoServiceStub.swift
//  SberProjectTests
//
//  Created by Алена on 16.09.2021.
//

@testable import SberProject
import UIKit

final class PhotoServiceStub: GetPhotoServiceProtocol {
    
    var loadAlbumStub: ((String, (Result<AlbumList, Error>) -> Void) -> Void)?
    
    func loadAlbum(userID: String, completion: @escaping (Result<AlbumList, Error>) -> Void) {
        loadAlbumStub?(userID, completion)
    }
}
