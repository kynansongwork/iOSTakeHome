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
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var viewModel: BooksViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(loadingSpinner)
        
        viewModel = BooksViewModel()
        viewModel?.delegate = self
        
        fetchBooks()
        loadingSpinner.isHidden = true
    }
    
    func fetchBooks() {
        
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        
        fetchInfo(view: self, url: "https://anapioficeandfire.com/api/books?page=1&pageSize=100", completion: { booksInfo in
            
            let books = try! JSONDecoder().decode([Book].self, from: booksInfo)
            self.viewModel?.loadData(books: books)
        })
    }
}
