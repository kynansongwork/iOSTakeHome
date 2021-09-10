//
//  NetworkRequests.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 10/09/2021.
//

import Foundation

func fetchInfo(url: String, completion: @escaping (Data) -> Void) {
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
        }
        
        if let apiData = data {
            completion(apiData)
        } else {
            print("No data was fetched.")
        }
        
    })
    task.resume()
}
