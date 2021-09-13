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
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var cachedHouses: [House] = []
    var filteredHouses: [House] = []
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(houseSearchBar)
        self.view.bringSubviewToFront(loadingSpinner)
        
        self.tableView.delegate = self
        setUpSearchBar()
        fetchHouses(page: 1, numberOfPages: 400)
        loadingSpinner.isHidden = true
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
    
    func fetchHouses(page: Int, numberOfPages: Int) {
        
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        
        fetchInfo(view: self, url: "https://anapioficeandfire.com/api/houses?page=\(page)&pageSize=\(numberOfPages)", completion: { housesInfo in
            
            let houses = try! JSONDecoder().decode([House].self, from: housesInfo)
            self.loadData(houses: houses)
        })
    }
    
    func loadData(houses: [House]) {
        cachedHouses = houses
        filteredHouses = cachedHouses
        
        DispatchQueue.main.async { [self] in
            
            loadingSpinner.stopAnimating()
            loadingSpinner.isHidden = true
            
            tableView.reloadData()
        }
    }
}
