//
//  UserInfoAPI.swift
//  appetit
//
//  Created by Mark Kang on 3/28/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation

class UserAPI{
    
    func isValidUser(username:String, password:String)-> Bool{
        return true
    }
    
    func saveUser(firstName: String, lastName: String, age: Int, email: String, maxCaloriesPerMeal: Int, maxCaloriesPerDay: Int) throws -> Bool{
        let userDataHandler = DataHandler()
        let user = userDataHandler.getUser()
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName, forKey: "lastName")
        user.setValue(age, forKey: "age")
        user.setValue(email, forKey: "email")
        user.setValue(maxCaloriesPerMeal, forKey: "maxCaloriesPerMeal")
        user.setValue(maxCaloriesPerDay, forKey: "maxCaloriesPerDay")
        
        do{
            try userDataHandler.save()
        } catch {
            throw MessageHandler.ErrorMessages.signUpFailed
        }
        return true
    }
}
