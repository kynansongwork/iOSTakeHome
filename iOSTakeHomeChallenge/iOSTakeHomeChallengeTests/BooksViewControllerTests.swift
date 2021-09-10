//
//  BooksViewControllerTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Kynan Song on 09/09/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class BooksViewControllerTests: XCTestCase {
    
    var viewController: BooksViewController?

    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "BooksView") as? BooksViewController
        viewController?.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanGetBooks() throws {
        
        guard let view = viewController else { return }
        
        let expectation = self.expectation(description: "Retrieving list of books")
        
        fetchInfo(view: view, url: "https://anapioficeandfire.com/api/books", completion: { booksInfo in
            
            let books = try! JSONDecoder().decode([Book].self, from: booksInfo)
            self.viewController?.loadData(books: books)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(viewController?.cachedBooks.count != 0)
    }


}
