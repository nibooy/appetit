//
//  UserInfoAPI.swift
//  appetit
//
//  Created by Mark Kang on 3/28/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation

class UserController{
    let userDataHandler: DataHandler;
    
    init() {
        userDataHandler = DataHandler()
    }
    func isValidUser(email:String, password:String) throws -> Bool{
        do{
            let userResult = try userDataHandler.getUserInfo(email: email, password: password)
            return userResult.count == 1
        }catch{
            throw ErrorMessage.ErrorCodes.dataSearchFailed
        }
    }
    
    func getUser(email:String, password: String) throws -> UserEntity{
         do{
            let userResult = try userDataHandler.getUserInfo(email: email, password: password)
            let userEntity = UserEntity(user: userResult[0])
            return userEntity
         }catch{
            throw ErrorMessage.ErrorCodes.dataSearchFailed
         }
    }
    
    func saveUser(email: String, password: String, firstName: String, lastName: String, maxCaloriesPerMeal: Int) throws{
        do{
            if try isValidUser(email: email, password: password){
                throw ErrorMessage.ErrorCodes.userExists
            }
        }catch{
            throw ErrorMessage.ErrorCodes.dataSearchFailed
        }
        let user = userDataHandler.getUserObject()
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName, forKey: "lastName")
        user.setValue(maxCaloriesPerMeal, forKey: "maxCaloriesPerMeal")
        do{
            try userDataHandler.save()
        } catch {
            throw ErrorMessage.ErrorCodes.dataSaveFailed
        }
    }
    
    func deleteUser(email: String, password: String) throws{
        do{
            try userDataHandler.deleteUser(email: email, password: password)
        }catch{
            throw ErrorMessage.ErrorCodes.dataSearchFailed
        }
    }
    
    func updateUser(email: String, password: String, firstName: String, lastName: String, maxCaloriesPerMeal: Int) throws{
        try deleteUser(email: email, password: password)
        try saveUser(email: email, password: password, firstName: firstName, lastName: lastName, maxCaloriesPerMeal: maxCaloriesPerMeal)
    }
    
}
