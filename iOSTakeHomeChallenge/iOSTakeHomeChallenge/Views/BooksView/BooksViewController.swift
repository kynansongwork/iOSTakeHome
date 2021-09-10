//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cachedBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBooks()
    }
    
    func fetchBooks() {
        fetchInfo(view: self, url: "https://anapioficeandfire.com/api/books", completion: { booksInfo in
            
            let books = try! JSONDecoder().decode([Book].self, from: booksInfo)
            self.loadData(books: books)
        })
    }
    
    func loadData(books: [Book]) {
        
        //Sorting books by number of pages. Designs not clear. However implementing a sort function might be useful.
//        let sortedBooks = books.sorted(by: { $0.numberOfPages < $1.numberOfPages })
//        cachedBooks = sortedBooks
        
        let sortedBooks = books.sorted(by: { $0.released < $1.released })
        cachedBooks = sortedBooks
        
        //UI refresh on background thread causing crash. - followed stack trace (unclear) so just searched reload data.
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }  
}
