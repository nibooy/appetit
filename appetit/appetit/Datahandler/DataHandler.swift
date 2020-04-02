//
//  UserInfoDataHandler.swift
//  appetit
//
//  Created by Mark Kang on 3/28/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit
import CoreData

class DataHandler{
    let appDelegate: AppDelegate;
    let context: NSManagedObjectContext;
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func getUserObject() -> NSManagedObject{
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let user = NSManagedObject(entity: userEntity!, insertInto: context)
        return user
    }
    
    func getUserInfo(email: String, password: String) throws -> [NSManagedObject]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %s and password = %s", email, password)
        do{
            let result = try fufillRequest(request: request)
            return result
        }catch{
            throw error
        }
    }
    
    func getVirtualFridgeObject() -> NSManagedObject{
        let userEntity = NSEntityDescription.entity(forEntityName: "VirtualFridge", in: context)
        let virtualFridge = NSManagedObject(entity: userEntity!, insertInto: context)
        return virtualFridge
    }
    
    /*Saves user info in sign up feature. Returns true if saved successfully, else throws error*/
    func save() throws{
        do{
            try context.save()
        } catch {
            throw error
        }
    }
    
    func fufillRequest(request: NSFetchRequest<NSFetchRequestResult>) throws -> [NSManagedObject]{
        do{
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
        }catch{
            throw error
        }
    }
    
}
