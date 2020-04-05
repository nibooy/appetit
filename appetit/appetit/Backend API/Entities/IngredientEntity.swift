//
//  VirtualFridgeEntity.swift
//  appetit
//
//  Created by Mark Kang on 4/5/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation
import CoreData

public struct IngredientEntity{
    
    let managedVirtualFridge: NSManagedObject;
    let email: String;
    let ingredient: String;
    let servings: Int;
    
    init(virtualFridge: NSManagedObject) {
        managedVirtualFridge = virtualFridge
        email = managedVirtualFridge.value(forKey: "email") as! String
        ingredient = managedVirtualFridge.value(forKey: "ingredient") as! String
        servings = managedVirtualFridge.value(forKey: "servings") as! Int
    }
}
