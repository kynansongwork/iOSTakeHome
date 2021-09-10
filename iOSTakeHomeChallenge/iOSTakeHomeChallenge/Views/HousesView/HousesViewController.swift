//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class HousesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var houseSearchBar: UISearchBar!
    
    var cachedHouses: [House] = []
    var filteredHouses: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(houseSearchBar)
        
        setUpSearchBar()
        fetchHouses()
    }
    
    func setUpSearchBar() {
        houseSearchBar.delegate = self
        
        let textFieldInsideSearchBar = houseSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        
        houseSearchBar.searchTextField.leftView?.tintColor = .gray
        houseSearchBar.barTintColor = .clear
        houseSearchBar.backgroundColor = .clear
        houseSearchBar.isTranslucent = true
        houseSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    func fetchHouses() {
        
        fetchInfo(view: self, url: "https://anapioficeandfire.com/api/houses", completion: { housesInfo in
            
            let houses = try! JSONDecoder().decode([House].self, from: housesInfo)
            self.loadData(houses: houses)
        })
    }
    
    func loadData(houses: [House]) {
        cachedHouses = houses
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
