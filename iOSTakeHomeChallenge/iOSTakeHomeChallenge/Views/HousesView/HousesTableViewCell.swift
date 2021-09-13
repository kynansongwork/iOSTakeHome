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
        
        nameLabel.text = house.name
        regionLabel.text = house.region
        wordsLabel.text =  house.words
    }
}
