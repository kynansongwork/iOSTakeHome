//
//  ViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 14/09/2021.
//

import Foundation

protocol ViewModel: AnyObject {
    var delegate: ViewModelDelegate? { get set }
}

enum ViewModelDidError: Error {
    case genericError
    case noResponse
}

protocol ViewModelDelegate: AnyObject {
    func viewModelDidUpdate()
    func viewModelDidError(error: ViewModelDidError)
    func viewModelNeedsUpdate()
}

extension ViewModelDelegate {
    func viewModelDidUpdate() {}
    func viewModelNeedsUpdate() {}
    func viewModelDidError(error: ViewModelDidError) {
        print("The view model hit an error: \(error)")
    }
}

class BaseViewModel: NSObject, ViewModel {
    weak var delegate: ViewModelDelegate?
    
    override init() {
        super.init()
    }
}
