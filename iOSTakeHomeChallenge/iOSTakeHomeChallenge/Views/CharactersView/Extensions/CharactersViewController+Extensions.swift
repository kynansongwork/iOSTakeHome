//
//  CharactersViewController+Extensions.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 09/09/2021.
//

import Foundation
import UIKit

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCharacters = cachedCharacters.filter( { (text) -> Bool in
            let searchString = text
            let nameRange = searchString.name.range(of: searchText, options: .caseInsensitive)
            let aliasRange = searchString.aliases.first?.range(of: searchText, options: .caseInsensitive)
            
            if nameRange == nil {
                return aliasRange != nil
            } else {
                return nameRange != nil
            }
        })
        
        //Need to work out how to refresh list when deleting text.
        if searchText.isEmpty {
            fetchCharacters(page: 1, pageSize: 400)
            self.tableView.reloadData()
        } else {
            cachedCharacters = filteredCharacters
            self.tableView.reloadData()
        }
    }
}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: cachedCharacters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == cachedCharacters.count {
            if cachedCharacters.count >= 30 {
                page += 1
                fetchCharacters(page: page, pageSize: 100)
                print("End of line: \(page)")
            }
        }
    }
}
