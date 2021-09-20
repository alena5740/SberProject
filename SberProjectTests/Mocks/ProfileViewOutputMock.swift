//
//  ProfileViewOutputMock.swift
//  SberProjectTests
//
//  Created by Алена on 16.09.2021.
//

@testable import SberProject
import UIKit

final class ProfileViewOutputMock: ProfileViewOutputProtocol {

    var updateViewStubCalled = false
    var hideLoadingViewCalled = false
    
    func updateView() {
        updateViewStubCalled = true
    }
    
    func hideLoadingView(isHidden: Bool) {
        hideLoadingViewCalled = true
    }
}
