//
//  HousesViewControllerTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Kynan Song on 10/09/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class HousesViewControllerTests: XCTestCase {
        
    var viewController: HousesViewController?

    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "HousesView") as? HousesViewController
        viewController?.loadView()
    }

    func testCanGetBooks() throws {
        
        guard let view = viewController else { return }
        
        let expectation = self.expectation(description: "Retrieving list of houses")
        
        fetchInfo(view: view, url: "https://anapioficeandfire.com/api/houses", completion: { housesInfo in
            
            let houses = try! JSONDecoder().decode([House].self, from: housesInfo)
            self.viewController?.viewModel?.loadData(houses: houses)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(viewController?.viewModel?.cachedHouses.count != 0)
    }
}
