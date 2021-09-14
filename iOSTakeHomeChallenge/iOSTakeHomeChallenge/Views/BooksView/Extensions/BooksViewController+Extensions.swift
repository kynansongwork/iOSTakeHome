//
//  BooksViewController+Extensions.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 09/09/2021.
//

import Foundation
import UIKit

extension BooksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let booksCount = self.viewModel?.cachedBooks.count {
            return booksCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let books = viewModel?.cachedBooks {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
            cell.setupWith(book: books[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension BooksViewController: ViewModelDelegate {
    
    func viewModelDidUpdate() {
        DispatchQueue.main.async { [self] in
            
            loadingSpinner.stopAnimating()
            loadingSpinner.isHidden = true
            
            tableView.reloadData()
        }
    }
}
