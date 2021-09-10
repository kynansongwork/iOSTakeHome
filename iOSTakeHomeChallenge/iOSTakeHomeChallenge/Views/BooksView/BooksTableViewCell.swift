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
        
        //https://newbedev.com/how-to-increase-the-uitableview-separator-height
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(1)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.gray
        self.addSubview(additionalSeparator)
        
        let releaseDate = dataFormatter(dateString: book.released)

        titleLabel.text = book.name
        dateLabel.text = releaseDate
        pagesLabel.text =  "\(book.numberOfPages) pages"
    }
}
