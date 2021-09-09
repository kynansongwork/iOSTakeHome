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
        
        //Need to work out how to refresh list when deleting text.
        if searchText.isEmpty {
            getHouses()
            self.tableView.reloadData()
        } else {
            cachedHouses = filteredHouses
            self.tableView.reloadData()
        }
    }
}

extension HousesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedHouses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
        cell.setupWith(house: cachedHouses[indexPath.row])
        return cell
    }
}
