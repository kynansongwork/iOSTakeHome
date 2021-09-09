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
        getHouses()
    }
    
    func setUpSearchBar() {
        houseSearchBar.delegate = self
        
        let textFieldInsideSearchBar = houseSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        
        houseSearchBar.searchTextField.leftView?.tintColor = .white
    }
    
    func getHouses() {
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/houses")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                print("Oops")
            }
            
            let houses = try! JSONDecoder().decode([House].self, from: data!)
            self.loadData(houses: houses)
            
        })
        task.resume()
    }
    
    func loadData(houses: [House]) {
        cachedHouses = houses
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
