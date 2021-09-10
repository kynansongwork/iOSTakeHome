//
//  CharacterTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 09/09/2021.
//

import Foundation
import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cultureLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    func setupWith(character: Character) {
        
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(1)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.gray
        self.addSubview(additionalSeparator)
        
        nameLabel.text = character.name == "" ? character.aliases.first : character.name
        cultureLabel.text = character.culture == "" ? "Unknown" : character.culture
        bornLabel.text = character.born == "" ? "Unknown" : character.born
        diedLabel.text = character.died == "" ? "Unknown" : character.died
        
        var seasons: String = ""
        
        for season in character.tvSeries {
            
            if season.contains("Season") {
                let numeral = season.replacingOccurrences(of: "Season", with: "").trimmingCharacters(in: .whitespaces)
                guard let number = Int(numeral)?.romanNumeral else { return }
                
                if numeral == "1" || numeral == "8" {
                    seasons.append(number)
                } else {
                    seasons.append(", \(number)")
                }
            } else {
                seasons.append("Not shown on TV")
            }
        }
        seasonLabel.text = seasons
    }
}
