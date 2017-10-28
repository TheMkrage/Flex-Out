//
//  ItemRating.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct Preference: Codable {
    var name: String
    var preference: String
}

struct ItemRating {
    var isFavorite: Bool? = false
    var preference: Double? = 0.0
    var item: Item?
    
    func getPreference() -> Preference {
        return Preference(name: item?.name ?? "", preference: "\(preference)")
    }
}
