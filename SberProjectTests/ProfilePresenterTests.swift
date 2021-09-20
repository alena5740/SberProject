//
//  ProfilePresenterTests.swift
//  ProfilePresenterTests
//
//  Created by Алена on 05.08.2021.
//

import XCTest
@testable import SberProject

class ProfilePresenterTests: XCTestCase {

    
    var profileServiceStub: ProfileServiceStub!
    var photoServiceStub: PhotoServiceStub!
    var presenter: ProfilePresenter!
    var delegate: ProfileViewOutputMock!
    
    override func setUp() {
        super.setUp()
        profileServiceStub = ProfileServiceStub()
        photoServiceStub = PhotoServiceStub()
        delegate = ProfileViewOutputMock()
        presenter = ProfilePresenter(profileService: profileServiceStub, photoService: photoServiceStub)
        presenter.viewDelegate = delegate
    }
    
    override func tearDown() {
        profileServiceStub = nil
        photoServiceStub = nil
        presenter = nil
        super.tearDown()
    }
    
    func testGivenProfileData() {
        // Arrange
        var callbackCalled = false
        
        profileServiceStub.loadProfileStub = { _, completion in
            callbackCalled = true
            completion(.failure(NetworkServiceError.dataIsNil))
        }

        // Act
        presenter.getData(userID: "")

        // Assert
        XCTAssert(callbackCalled, "Кейс получения моделей не вызван")
        XCTAssertFalse(delegate.updateViewStubCalled, "Не вызван")
    }
    
    func testGivenProfilePhotos() {
        
        // Arrange
        var callbackCalled = false
        var id = ""
        
        photoServiceStub.loadAlbumStub = { userID, completion in
            callbackCalled = true
            id = userID
            completion(.failure(NetworkServiceError.decodable))
        }
        // Act
        presenter.getPhotos(userID: "1234")
        
        // Assert
        XCTAssertTrue(callbackCalled)
        XCTAssertTrue(id == "1234")
        XCTAssertFalse(delegate.updateViewStubCalled, "Не вызван")
    }

}


enum NetworkServiceError: Error {
    case wrongURL
    case decodable
    case dataIsNil
    case unknown
    case wrongPage
}
