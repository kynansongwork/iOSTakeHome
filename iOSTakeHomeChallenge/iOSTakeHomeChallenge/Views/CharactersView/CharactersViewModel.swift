//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 14/09/2021.
//

import Foundation


class CharactersViewModel: BaseViewModel {
    
    var cachedCharacters: [Character] = []
    var filteredCharacters: [Character] = []
    
    func loadData(characters: [Character]) {

        //Appending characters this way so when the tableview more characters can be loaded, instead of loading everything at once.
        for character in characters {
            cachedCharacters.append(character)
            filteredCharacters.append(character)
        }

        self.delegate?.viewModelDidUpdate()
    }
    
}
