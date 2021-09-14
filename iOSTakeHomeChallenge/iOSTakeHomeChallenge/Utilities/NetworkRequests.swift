//
//  NetworkRequests.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 10/09/2021.
//

import Foundation
import UIKit

func fetchInfo(view: UIViewController, url: String, completion: @escaping (Data) -> Void) {
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    let config: URLSessionConfiguration = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 15
    config.httpAdditionalHeaders = [
        "Content-Type": "application/json"
    ]
    let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
        if (error != nil) {
            print("Oops")
            networkErrorMessage(view: view, error: error)
        } else {
            if let apiData = data {
                completion(apiData)
            } else {
                print("No data was fetched.")
            }
        }
        
    })
    task.resume()
}

//Working out how to fetch fuller list of characters.
func fetchAll(view: UIViewController, url: String, completion: @escaping (Data) -> Void) {
    
    for i in 1...1000 {
        var request = URLRequest(url: URL(string: "\(url)/\(i)")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                print("Oops")
                return
            } else {
                if let apiData = data {
                    DispatchQueue.main.async {
                        completion(apiData)
                    }
                } else {
                    print("No data was fetched.")
                    networkErrorMessage(view: view, error: nil)
                }
            }
            
        })
        task.resume()
    }
}

func networkErrorMessage(view: UIViewController, error: Error?) {
    DispatchQueue.main.async {
        
        guard let errorMessage = error else { return }
        
        let alert = UIAlertController(title: "There was an issue", message: "There was an issue fetching the data: \(errorMessage)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view.present(alert, animated: true)
    }
    
}
