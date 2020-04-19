//
//  VirtualFridgeAPI.swift
//  appetit
//
//  Created by Mark Kang on 4/4/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation
import UIKit

class VirtualFridgeController{
    let userDataHandler: DataHandler
    var userEmail: String
    
    init() {
        userDataHandler = DataHandler()
        userEmail = ""
    }
    
    /*Returns a list of IngredientEntity structs that belong to the user in the parameters.*/
    func getUserIngredients(email: String) throws -> [IngredientEntity]{
        var listOfIngredients: [IngredientEntity] = []
        do{
            let listOfIngredientObjects = try userDataHandler.getVirtualFridgeIngredients(email: email)
            if listOfIngredients.count > 0  {
                userEmail = listOfIngredientObjects[0].value(forKey: "email") as! String
            }
            for ingredientObject in listOfIngredientObjects{
                let ingredient = ingredientObject.value(forKey: "ingredient") as! String
                let servings = ingredientObject.value(forKey: "servings") as! Int
                let image = ingredientObject.value(forKey: "image") as! UIImage
                let ingredientEntity = IngredientEntity(ingredientName: ingredient, servingsAmount: servings, uiImage: image)
                listOfIngredients.append(ingredientEntity)
            }
        }catch{
            throw ErrorMessage.ErrorCodes.dataSearchFailed
        }
        return listOfIngredients
    }
    
    /*Add ingredients. If it already exists, it will add to the amount of servings already existed. If it is new, it will make a new entry */
    func addIngredient(email: String, ingredient: String, servings: Int, uiImage: UIImage) throws{
        let image = uiImage.pngData()
        let virtualFridge = userDataHandler.getDatabaseObject(entity: "VirtualFridge")
        var newServings = servings
        var ingredientMatches:[IngredientEntity] = []
        ingredientMatches = try getIngredientMatches(email: email, ingredient: ingredient)
        if ingredientMatches.count > 0{
            let ingredientMatch = ingredientMatches[0]
            try subtractIngredient(email: email, ingredient: ingredientMatch.ingredient, servings: ingredientMatch.servings)
            newServings = ingredientMatch.servings + servings
        }
            virtualFridge.setValue(email, forKey: "email")
            virtualFridge.setValue(ingredient, forKey: "ingredient")
            virtualFridge.setValue(newServings, forKey: "servings")
            virtualFridge.setValue(image, forKey: "image")
        do{
            try userDataHandler.save()
        } catch {
            throw ErrorMessage.ErrorCodes.dataSaveFailed
        }
    }
    
    private func getIngredientMatches(email: String, ingredient: String) throws -> [IngredientEntity]{
        var ingredientMatchList: [IngredientEntity] = []
        do{
            let ingredientMatches = try userDataHandler.getIngredient(email: email, ingredient: ingredient)
            for ingredient in ingredientMatches{
                let ingredientName = ingredient.value(forKey: "ingredient") as! String
                let ingredientServings = ingredient.value(forKey: "servings") as! Int
                let image = ingredient.value(forKey: "image") as! UIImage
                let ingredientEntity = IngredientEntity(ingredientName: ingredientName, servingsAmount: ingredientServings, uiImage: image)
                ingredientMatchList.append(ingredientEntity)
            }
        }catch{
            throw ErrorMessage.ErrorCodes.dataSearchFailed
        }
        
        return ingredientMatchList
    }
    
    /*Subtracting an ingredient will delete if the amount requested is equal to the amount available. If there is leftover servings, it will add it back to the virtual fridge. Will throw an error if the ingredient does not exist*/
    func subtractIngredient(email: String, ingredient: String, servings: Int) throws{
        var ingredientMatches:[IngredientEntity] = []
        do{
            ingredientMatches = try getIngredientMatches(email: email, ingredient: ingredient)
            guard ingredientMatches.count > 0 else{
                throw ErrorMessage.ErrorCodes.ingredientDoesNotExist
            }
            let uiImage = try userDataHandler.getIngredient(email: email, ingredient: ingredient)[0].value(forKey: "image") as! UIImage
            try userDataHandler.deleteIngredient(email: email, ingredient: ingredient)
            if servings < ingredientMatches[0].servings {
                let subtractedServings = ingredientMatches[0].servings - servings
                try addIngredient(email: email, ingredient: ingredient, servings: subtractedServings, uiImage: uiImage)
            }
        }catch {
            throw ErrorMessage.ErrorCodes.dataSearchFailed
        }
    }
    
    func updateIngredient(email: String, ingredient: String, servings: Int) throws{
        let uiImage = try userDataHandler.getIngredient(email: email, ingredient: ingredient)[0].value(forKey: "image") as! UIImage
        do{
           try userDataHandler.deleteIngredient(email: email, ingredient: ingredient)
        }catch ErrorMessage.ErrorCodes.ingredientDoesNotExist{
            throw ErrorMessage.ErrorCodes.ingredientDoesNotExist
        }catch{
            throw ErrorMessage.ErrorCodes.dataSearchFailed
        }
        try addIngredient(email: email, ingredient: ingredient, servings: servings, uiImage: uiImage)
    }
}
