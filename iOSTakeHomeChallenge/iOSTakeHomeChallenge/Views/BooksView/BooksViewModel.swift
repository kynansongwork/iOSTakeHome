//
//  BooksViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 14/09/2021.
//

import Foundation

class BooksViewModel: BaseViewModel {
    
    var cachedBooks: [Book] = []
    
    func loadData(books: [Book]) {
        
        //Sorting books by number of pages. Designs not clear. However implementing a sort function might be useful.
//        let sortedBooks = books.sorted(by: { $0.numberOfPages < $1.numberOfPages })
//        cachedBooks = sortedBooks
        
        let sortedBooks = books.sorted(by: { $0.released < $1.released })
        cachedBooks = sortedBooks
        
        self.delegate?.viewModelDidUpdate()
    }
}
