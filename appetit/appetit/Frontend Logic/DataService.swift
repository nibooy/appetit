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
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
//                    print("json:\n \(json)")
//                } catch {
//                    print("error")
//                }
            }
            
        }
        task.resume()
    }
    
}

//{"foods":[{"food_name":"Beef Jerky, Chipotle Adobo","brand_name":"Three Jerks","serving_qty":1,"serving_unit":"oz","serving_weight_grams":28,"nf_calories":100,"nf_total_fat":3,"nf_saturated_fat":1,"nf_cholesterol":30,"nf_sodium":350,"nf_total_carbohydrate":8,"nf_dietary_fiber":1,"nf_sugars":6,"nf_protein":10,"nf_potassium":null,"nf_p":null,"full_nutrients":[{"attr_id":203,"value":10},{"attr_id":204,"value":3},{"attr_id":205,"value":8},{"attr_id":208,"value":100},{"attr_id":269,"value":6},{"attr_id":291,"value":1},{"attr_id":301,"value":26},{"attr_id":303,"value":1.44},{"attr_id":307,"value":350},{"attr_id":318,"value":300},{"attr_id":401,"value":0},{"attr_id":601,"value":30},{"attr_id":605,"value":0},{"attr_id":606,"value":1}],"nix_brand_name":"Three Jerks","nix_brand_id":"551af50449bbebc5780a61b0","nix_item_name":"Beef Jerky, Chipotle Adobo","nix_item_id":"5556515436f95593518aa94e","metadata":{},"source":8,"ndb_no":null,"tags":null,"alt_measures":null,"lat":null,"lng":null,"photo":{"thumb":"https://d1r9wva3zcpswd.cloudfront.net/555652c40761f2ce5d7e076d.jpeg","highres":null,"is_user_uploaded":false},"note":null,"updated_at":"2019-01-27T10:39:22+00:00","nf_ingredient_statement":"Beef, Water, Sugar, Less than 2% Salt, Corn Syrup Solids, Dried Soy Sauce (Soybeans, Salt, Wheat), Hydrolyzed Corn and Soy Protein, Monosodium Glutamate, Maltodextrin, Flavorings, Sodium Erythorbate, Sodium Nitrite."}]}
