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
        
        guard let cachedCharacters = viewModel?.cachedCharacters else { return }
        
        viewModel?.filteredCharacters = cachedCharacters.filter( { (text) -> Bool in
            let searchString = text
            let nameRange = searchString.name.range(of: searchText, options: .caseInsensitive)
            let aliasRange = searchString.aliases.first?.range(of: searchText, options: .caseInsensitive)
            
            if nameRange == nil {
                return aliasRange != nil
            } else {
                return nameRange != nil
            }
        })

        if searchText.isEmpty {
            viewModel?.filteredCharacters = cachedCharacters
            self.tableView.reloadData()
        } else {
            self.tableView.reloadData()
        }
    }
}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredCount = viewModel?.filteredCharacters.count {
            return filteredCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let filteredCharacters = viewModel?.filteredCharacters {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
            cell.setupWith(character: filteredCharacters[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let filteredCharacters = viewModel?.filteredCharacters {
            if indexPath.row + 1 == filteredCharacters.count {
                if filteredCharacters.count >= 30 {
                    page += 1
                    fetchCharacters(page: page, pageSize: 100)
                    print("End of line: \(page)")
                }
            }
        }
    }
}

extension CharactersViewController: ViewModelDelegate {
        
    func viewModelDidUpdate() {
        DispatchQueue.main.async { [self] in
            
            loadingSpinner.stopAnimating()
            loadingSpinner.isHidden = true
            
            tableView.reloadData()
        }
    }
}
