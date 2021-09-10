//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class CharactersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var characterViewSearchBar: UISearchBar!
    
    var cachedCharacters: [Character] = []
    var filteredCharacters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(characterViewSearchBar)
        
        setUpSearchBar()
        getCharacters()
        //getAllCharacters()
    }
    
    func setUpSearchBar() {
        characterViewSearchBar.delegate = self
        
        let textFieldInsideSearchBar = characterViewSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        
        characterViewSearchBar.searchTextField.leftView?.tintColor = .white
    }
    
    func getAllCharacters() {
        
        for i in 1...600 {
            var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/characters/\(i)")!)

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
                
                if let unwrappedData = data {
                    let character = try! JSONDecoder().decode(Character.self, from: unwrappedData)
                    self.loadDataTwo(character: character)
                }
            })
            task.resume()
        }
    }
    
    func getCharacters() {
        
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/characters")!)
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
            
            let characters = try! JSONDecoder().decode([Character].self, from: data!)
            self.loadData(characters: characters)
            
        })
        task.resume()
    }
    
    func fetchCharacters() {
        
        fetchInfo(url: "https://anapioficeandfire.com/api/characters", completion: { charactersInfo in
            let characters = try! JSONDecoder().decode([Character].self, from: charactersInfo)
            self.loadData(characters: characters)
        })
    }
    
    func loadData(characters: [Character]) {
        cachedCharacters = characters
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadDataTwo(character: Character) {
        cachedCharacters.append(character)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
