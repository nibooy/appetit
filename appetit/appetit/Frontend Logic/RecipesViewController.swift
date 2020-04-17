//
//  RecipesViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    struct Result: Decodable{
        let hits: [Recipe]
    }
    struct Recipe: Decodable{
        let recipe: RecipeInfo
    }
    
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var atGlanceInfo: UIView!
    let urlString = "https://api.edamam.com/search?"
    let apiKey = "e789925699272fcebc9ebbc5957d99b1"
    let appId = "798efc6d"
    var userEmail: String = ""
    var recipeList: [Recipe] = []
    var listOfIngredients: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let virtualFridgeController = VirtualFridgeController()
        do{
            let listOfUserIngredients:[IngredientEntity] = try virtualFridgeController.getUserIngredients(email: userEmail)
            for ingredient in listOfUserIngredients{
                listOfIngredients = listOfIngredients + " " + ingredient.ingredient
            }
        }catch ErrorMessage.ErrorCodes.dataSearchFailed{
            //error is that we could not read from database
        }catch{
            //unknown error
        }
        let mySession = URLSession(configuration: URLSessionConfiguration.default)
        let urlWithQueryParameters = urlString + "app_key=" + apiKey + "&app_id" + appId + "&q=" + listOfIngredients
        let url = URL(string: urlWithQueryParameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        let task = mySession.dataTask(with: url) { data, response, error in
            guard error == nil else {
                //error message here for internet problems
                return
            }
            guard let jsonData = data else {
                //error message here for no data
                return
            }
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Result.self, from: jsonData)
                self.recipeList = result.hits
                DispatchQueue.main.async {
                    /*TODO: Reload table data since data structure is relaoded*/
                }
            } catch {
                //error message here while loading data
            }
        }
        task.resume()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        //dismisses screen when tabs to another screen
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
