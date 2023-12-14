//
//  String+Extensions.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/13/23.
//

import Foundation

extension String {
    func formatDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy HH:mm a"
            
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        }
        
        return nil
    }
}
