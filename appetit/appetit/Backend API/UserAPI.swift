//
//  UserInfoAPI.swift
//  appetit
//
//  Created by Mark Kang on 3/28/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation

class UserAPI{
    let userDataHandler: DataHandler;
    
    init() {
        userDataHandler = DataHandler()
    }
    func isValidUser(email:String, password:String) throws -> Bool{
        do{
            let userResult = try userDataHandler.getUserInfo(email: email, password: password)
            return userResult.count > 0
        }catch{
            throw MessageHandler.ErrorMessages.dataSearchFailed
        }
    }
    
    func getUserFirstName(email:String, password: String) throws -> String{
         do{
             let userResult = try userDataHandler.getUserInfo(email: email, password: password)
             return userResult[0].value(forKey: "firstName") as! String
         }catch{
             throw MessageHandler.ErrorMessages.dataSearchFailed
         }
    }
    func getUserLastName(email:String, password: String) throws -> String{
         do{
             let userResult = try userDataHandler.getUserInfo(email: email, password: password)
             return userResult[0].value(forKey: "lastName") as! String
         }catch{
             throw MessageHandler.ErrorMessages.dataSearchFailed
         }
    }
    
    func saveUser(firstName: String, lastName: String, age: Int, email: String, maxCaloriesPerMeal: Int) throws -> Bool{
        let user = userDataHandler.getUserObject()
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName, forKey: "lastName")
        user.setValue(age, forKey: "age")
        user.setValue(email, forKey: "email")
        user.setValue(maxCaloriesPerMeal, forKey: "maxCaloriesPerMeal")
        do{
            try userDataHandler.save()
        } catch {
            throw MessageHandler.ErrorMessages.signUpFailed
        }
        return true
    }
}
