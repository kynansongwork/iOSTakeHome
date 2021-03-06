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
    
    func testCanGetBooks() throws {
        
        guard let view = viewController else { return }
        
        let expectation = self.expectation(description: "Retrieving list of books")
        
        fetchInfo(view: view, url: "https://anapioficeandfire.com/api/books", completion: { booksInfo in
            
            let books = try! JSONDecoder().decode([Book].self, from: booksInfo)
            self.viewController?.viewModel?.loadData(books: books)
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(viewController?.viewModel?.cachedBooks.count != 0)
    }
}
