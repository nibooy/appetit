//
//  RecipesViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var atGlanceInfo: UIView!
    let urlString = "https://api.edamam.com/search?"
    let apiKey = "e789925699272fcebc9ebbc5957d99b1"
    let appId = "798efc6d"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mySession = URLSession(configuration: URLSessionConfiguration.default)
                let urlWithQueryParameters = urlString
                let url = URL(string: urlWithQueryParameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
                let task = mySession.dataTask(with: url) { data, response, error in
                
                    guard error == nil else {
                        //error message here for internet problems
                        return
                    }
                    guard let jsonData = data else {
                        print("No data")
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
//                        let result = try decoder.decode(//struct here, from: jsonData)
//                        
                        DispatchQueue.main.async {
                            //reload data here
                        }
                    } catch {
                        // error message here while loading data
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
