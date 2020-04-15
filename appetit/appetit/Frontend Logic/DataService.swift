//
//  DataService.swift
//  appetit
//
//  Created by Yoo Bin Shin on 4/15/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation

class DataService {
    
    static let dataService = DataService()
    static func searchAPI(codeNumber: String){
        enum Error: Swift.Error {
            case requestFailed
        }

        let url = "https://trackapi.nutritionix.com/v2/search/item"
        let urlWithParams = url + "?upc=851045005013"
        let myUrl = URL(string: urlWithParams)
        guard let requestUrl = myUrl else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"
        //Headers
        request.setValue("2fad0373", forHTTPHeaderField: "x-app-id")
        request.setValue("d6ba77ec6ee3f506b47ecc748a85e4e3", forHTTPHeaderField: "x-app-key")

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            
        }
        task.resume()
    }
    
}
