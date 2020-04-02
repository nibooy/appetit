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
    func getUser() -> NSManagedObject{
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let user = NSManagedObject(entity: userEntity!, insertInto: context)
        return user
    }
    
    func getVirtualFridge() -> NSManagedObject{
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
    
}
