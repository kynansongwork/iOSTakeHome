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
        
        filteredHouses = cachedHouses.filter( { (text) -> Bool in
            let searchString = text
            let range = searchString.name.range(of: searchText, options: .caseInsensitive)
            return range != nil
        })

        if searchText.isEmpty {
            filteredHouses = cachedHouses
            self.tableView.reloadData()
        } else {
            self.tableView.reloadData()
        }
    }
}

extension HousesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //cachedHouses.count
        filteredHouses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
        cell.setupWith(house: filteredHouses[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == filteredHouses.count {
            if filteredHouses.count >= 50 {
                page += 1
                fetchHouses(page: page, numberOfPages: 100)
                print("End of line, Houses: \(page)")
            }
        }
    }
}
