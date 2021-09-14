//
//  HousesViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 14/09/2021.
//

import Foundation

class HousesViewModel: BaseViewModel {
    
    var cachedHouses: [House] = []
    var filteredHouses: [House] = []
    
    func loadData(houses: [House]) {
        
        //Saving houses this way will cause everything to be loaded at once, which causes a UI jump.
//        cachedHouses = houses
//        filteredHouses = cachedHouses

        for house in houses {
            cachedHouses.append(house)
            filteredHouses.append(house)
        }
        
        self.delegate?.viewModelDidUpdate()
    }
    
}
