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
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var cachedCharacters: [Character] = []
    var filteredCharacters: [Character] = []
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(characterViewSearchBar)
        self.view.bringSubviewToFront(loadingSpinner)
        
        self.tableView.delegate = self
        setUpSearchBar()
        fetchCharacters(page: page, pageSize: 400)
    }
    
    func setUpSearchBar() {
        characterViewSearchBar.delegate = self
        
        let textFieldInsideSearchBar = characterViewSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        
        characterViewSearchBar.searchTextField.leftView?.tintColor = .gray
        characterViewSearchBar.barTintColor = .clear
        characterViewSearchBar.backgroundColor = .clear
        characterViewSearchBar.isTranslucent = true
        characterViewSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    // This uses the fetch all url on the api docs
    func fetchCharacters(page: Int, pageSize: Int) {
        
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        
        fetchInfo(view: self, url: "https://anapioficeandfire.com/api/characters?page=\(page)&pageSize=\(pageSize)", completion: { charactersInfo in
            let characters = try! JSONDecoder().decode([Character].self, from: charactersInfo)
            self.loadData(characters: characters)
        })
    }
    
    func loadData(characters: [Character]) {
        //cachedCharacters = characters
        
        for character in characters {
            cachedCharacters.append(character)
        }
        
        DispatchQueue.main.async { [self] in
            
            loadingSpinner.stopAnimating()
            loadingSpinner.isHidden = true
            
            tableView.reloadData()
        }
    }
}
