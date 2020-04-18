//
//  DataService.swift
//  appetit
//
//  Created by Yoo Bin Shin on 4/15/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation

/// A food item returned from Nutritionix API
struct FoodItem: Codable {
    /// Name of the food
    var food_name: String

    /// Amount in a serving
    var serving_qty: Float

    /// Unit of a serving
    var serving_unit: String
}

/// JSON return from Nutritionix API
struct FoodJSON: Codable {
    /// List of food items
    var foods: [FoodItem]
}


final class DataService {
    static let dataService = DataService()
    
    static func searchAPI(codeNumber: String) -> (name: String, qty: Float, unit: String) {
        enum Error: Swift.Error {
            case requestFailed
        }
        let url = "https://trackapi.nutritionix.com/v2/search/item"
        let urlWithParams = url + "?upc=" + codeNumber
        let myUrl = URL(string: urlWithParams)
        guard let requestUrl = myUrl else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"
        //Headers
        request.setValue("2fad0373", forHTTPHeaderField: "x-app-id")
        request.setValue("d6ba77ec6ee3f506b47ecc748a85e4e3", forHTTPHeaderField: "x-app-key")
        
        var name = ""
        var qty = Float(0)
        var unit = ""
        
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

            guard let data = data else {
                print("No data")
                return
            }
            
//                do {
//                    let convertedString = String(data: data, encoding: String.Encoding.utf8) // the data will be converted to the string
//                    print(convertedString ?? "defaultvalue")
//                }
            
            do {
                let decoder = JSONDecoder()
                let foodJSON = try decoder.decode(FoodJSON.self, from: data)
                print(foodJSON.foods)
                for food in foodJSON.foods {
                    name.append(food.food_name)
                    qty+=food.serving_qty
                    unit = food.serving_unit
                    print("Food name: \(name), serving quantity: \(qty), serving unit: \(unit)")
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        task.resume()
        print("hey"+name)
        return(name, qty, unit)
    }
    
}

