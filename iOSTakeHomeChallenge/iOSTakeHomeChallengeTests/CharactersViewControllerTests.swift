//
//  CharactersViewControllerTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Kynan Song on 10/09/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class CharactersViewControllerTests: XCTestCase {
    
    var viewController: CharactersViewController?

    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "CharactersView") as? CharactersViewController
        viewController?.loadView()
    }

    func testCanGetBooks() throws {
        
        guard let view = viewController else { return }
        
        let expectation = self.expectation(description: "Retrieving list of characters")
        
        fetchInfo(view: view, url: "https://anapioficeandfire.com/api/characters", completion: { charactersInfo in
            
            let characters = try! JSONDecoder().decode([Character].self, from: charactersInfo)
            self.viewController?.loadData(characters: characters)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(viewController?.cachedCharacters.count != 0)
    }
}
