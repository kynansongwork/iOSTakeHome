//
//  TabBarController.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 08/09/2021.
//

import Foundation
import UIKit

class MainTabController: UITabBarController {
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        
        let tabBarColour = UIColor(hex: "#2596be")
        
        mainTabBar.barTintColor = .black.withAlphaComponent(0.2)
    }
}
