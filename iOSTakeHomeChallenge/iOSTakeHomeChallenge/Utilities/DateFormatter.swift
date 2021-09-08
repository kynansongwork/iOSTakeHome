//
//  DateFormatter.swift
//  iOSTakeHomeChallenge
//
//  Created by Kynan Song on 08/09/2021.
//

import Foundation

func dataFormatter(dateString: String) -> String {

    let dateFormatter = DateFormatter()
    let stringFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.locale = Locale.init(identifier: "en_GB")
    let s = dateFormatter.date(from: dateString)
    
    if let time = s {
        stringFormatter.dateFormat = "MMM yyyy"
        return stringFormatter.string(from: time)
    }
    
    return "Date could not be retrieved"
}
