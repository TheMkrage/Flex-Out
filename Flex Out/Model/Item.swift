//
//  Item.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct Item: Codable {
    
    init(price: String, name: String, calories: String) {
        self.price = price
        self.name = name
        self.calories = calories
    }
    
    // Variables specific to Item's qualities
    let price: String
    let name: String
    let calories: String
}
