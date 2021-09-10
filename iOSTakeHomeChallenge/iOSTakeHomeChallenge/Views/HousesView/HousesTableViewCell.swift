//
//  HousesTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 08/09/2021.
//

import Foundation
import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    func setupWith(house: House) {
        
//        let screenSize = UIScreen.main.bounds
//        let separatorHeight = CGFloat(1)
//        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
//        additionalSeparator.backgroundColor = UIColor.gray
//        self.addSubview(additionalSeparator)
        
        nameLabel.text = house.name
        regionLabel.text = house.region
        wordsLabel.text =  house.words
    }
}
