//
//  IngredientEntity.swift
//  appetit
//
//  Created by Mark Kang on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import Foundation
import UIKit

public struct IngredientEntity{
    let ingredient: String
    let servings: Int
    let image: UIImage
    init(ingredientName: String, servingsAmount: Int, uiImage: UIImage) {
        ingredient = ingredientName
        servings = servingsAmount
        image = uiImage
    }
}
