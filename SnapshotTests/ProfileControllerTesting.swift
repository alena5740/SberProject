//
//  SnapshotTests.swift
//  SnapshotTests
//
//  Created by Алена on 20.09.2021.
//

import XCTest
import SnapshotTesting
@testable import SberProject

class ProfileControllerTesting: XCTestCase {

    func testMyViewController() {
      let vc = ProfileViewController()

        assertSnapshot(matching: vc, as: .image(on: .iPhone8Plus(.portrait)))
        assertSnapshot(matching: vc, as: .image(on: .iPhoneSe(.portrait)))
    }
}
