//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class BooksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cachedBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
    }
    
    func getBooks() {
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/books")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                print("Oops")
            }
            
            let books = try! JSONDecoder().decode([Book].self, from: data!)
            self.loadData(books: books)
            
        })
        task.resume()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
    
}

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    func setupWith(book: Book) {
        
        let releaseDate = dataFormatter(dateString: book.released)

        titleLabel.text = book.name
        dateLabel.text = releaseDate
        pagesLabel.text =  "\(book.numberOfPages) pages"
    }
}
