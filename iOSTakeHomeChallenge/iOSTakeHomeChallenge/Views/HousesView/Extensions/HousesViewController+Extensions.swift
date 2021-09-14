//
//  HousesViewController+Extensions.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 08/09/2021.
//

import Foundation
import UIKit

extension HousesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let cachedHouses = viewModel?.cachedHouses else { return }
        
        viewModel?.filteredHouses = cachedHouses.filter( { (text) -> Bool in
            let searchString = text
            let range = searchString.name.range(of: searchText, options: .caseInsensitive)
            return range != nil
        })

        if searchText.isEmpty {
            viewModel?.filteredHouses = cachedHouses
            self.tableView.reloadData()
        } else {
            self.tableView.reloadData()
        }
    }
}

extension HousesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredCount = viewModel?.filteredHouses.count {
            return filteredCount
        } else {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let filtered = viewModel?.filteredHouses {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
            cell.setupWith(house: filtered[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let filtered = viewModel?.filteredHouses {
            if indexPath.row + 1 == filtered.count {
                if filtered.count >= 50 {
                    page += 1
                    fetchHouses(page: page, numberOfPages: 100)
                    print("End of line, Houses: \(page)")
                }
            }
        }
    }
}

extension HousesViewController: ViewModelDelegate {
    
    func viewModelDidUpdate() {
        DispatchQueue.main.async { [self] in
            
            loadingSpinner.stopAnimating()
            loadingSpinner.isHidden = true
            
            tableView.reloadData()
        }
    }
}
