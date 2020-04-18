//
//  RecipeController.swift
//  appetit
//
//  Created by Mark Kang on 4/17/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation

class RecipeController{
    let userDataHandler: DataHandler;
    
    init() {
        userDataHandler = DataHandler()
    }
    
    func saveUserRecipe(email: String, recipeInfo: RecipeInfo) throws{
        let recipesObject = userDataHandler.getDatabaseObject(entity: "Recipes")
        recipesObject.setValue(recipeInfo.label, forKey: "label")
        recipesObject.setValue(recipeInfo.image, forKey: "image")
        recipesObject.setValue(recipeInfo.uri, forKey: "uri")
        recipesObject.setValue(recipeInfo.url, forKey: "url")
        recipesObject.setValue(recipeInfo.healthLabels, forKey: "healthLabels")
        recipesObject.setValue(recipeInfo.ingredientLines, forKey: "ingredientLines")
        do{
            try userDataHandler.save()
        } catch {
            throw ErrorMessage.ErrorCodes.dataSaveFailed
        }
    }
    
    func getUserRecipe(email: String) throws -> [RecipeInfo]{
        let recipeMatches = try userDataHandler.getUserRecipes(email: email)
        var recipeList: [RecipeInfo] = []
        for recipe in recipeMatches{
            let label = recipe.value(forKey: "label") as! String
            let image = recipe.value(forKey: "image") as! String
            let uri = recipe.value(forKey: "uri") as! String
            let url = recipe.value(forKey: "url") as! String
            let healthLabels = recipe.value(forKey: "healthLabels") as! [String]
            let ingredientLines = recipe.value(forKey: "ingredientLines") as! [String]
            let recipeEntity = RecipeInfo(label: label, image: image, uri: uri, url: url, healthLabels: healthLabels, ingredientLines:  ingredientLines)
            recipeList.append(recipeEntity)
        }
        return recipeList
    }
}
