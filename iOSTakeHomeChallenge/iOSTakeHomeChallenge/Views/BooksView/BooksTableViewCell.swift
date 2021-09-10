//
//  BooksTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 09/09/2021.
//

import Foundation
import UIKit

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
