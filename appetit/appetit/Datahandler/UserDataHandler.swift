//
//  UserInfoDataHandler.swift
//  appetit
//
//  Created by Mark Kang on 3/28/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit
import CoreData

class UserDataHandler{
    let appDelegate: AppDelegate;
    let context: NSManagedObjectContext;
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }

    /*Saves user info in sign up feature. Returns true if saved successfully, else throws error*/
    func save(firstName: String, lastName: String, age: Int, gender: String, maxCaloriesPerMeal: Int, maxCaloriesPerDay: Int) throws -> Bool{
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let user = NSManagedObject(entity: userEntity!, insertInto: context)
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName, forKey: "lastName")
        user.setValue(age, forKey: "age")
        user.setValue(gender, forKey: "gender")
        user.setValue(maxCaloriesPerMeal, forKey: "maxCaloriesPerMeal")
        user.setValue(maxCaloriesPerDay, forKey: "maxCaloriesPerDay")
        do{
            try context.save()
        } catch {
            throw MessageHandler.ErrorMessages.signUpFailed
        }
        return true
    }
    
    
}
