//
//  BooksViewControllerTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Kynan Song on 09/09/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class BooksViewControllerTests: XCTestCase {
    
    var viewController: HousesViewController!

    override func setUpWithError() throws {
        viewController = HousesViewController()
        viewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanGetHouses() throws {
//        viewController.getHouses()
//        
//        let expectation = expectation(description: "Houses fetched")
//        wait(for: [expectation], timeout: 4)
//        XCTAssertTrue(viewController.cachedHouses.count != 0)
    }


}
