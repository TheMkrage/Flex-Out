//
//  ItemRatingStore.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

struct ItemRatingStore {
    static var shared = ItemRatingStore()
    private init() { }
    
    func getLocalPreferences(isFavoritesOnly: Bool) -> [Preference] {
        let userDefaults = UserDefaults.standard
        guard let preferences = userDefaults.dictionary(forKey: "preferences") as? [String: Double] else {
            userDefaults.set([], forKey: "favorites")
            userDefaults.set([], forKey: "preferences")
            return []
        }
        var toReturn = [Preference]()
        
        for (name, preference) in preferences {
            if (isFavoritesOnly && self.getItemRating(with: name).isFavorite ?? false) || (!isFavoritesOnly) {
                toReturn.append(Preference(name: name, preference: "\(preference)"))
            }
            
            
        }
        return toReturn
    }
    
    func getItemRating(with name:String) -> ItemRating {
        let userDefaults = UserDefaults.standard
        guard let favorites = userDefaults.array(forKey: "favorites"), let preferences = userDefaults.dictionary(forKey: "preferences") as? [String: Double] else {
            userDefaults.set([], forKey: "favorites")
            userDefaults.set([], forKey: "preferences")
            return ItemRating(isFavorite: false, preference: 0.0, item: nil)
        }
        let isContainedInFavorites = favorites.contains { (item) -> Bool in
            guard let nameOfCurrent = item as? String else {
                return false
            }
            return nameOfCurrent == name
        }
        let preference = preferences[name] == nil ? 0 : preferences[name]
        var itemRating = ItemRating()
        itemRating.isFavorite = isContainedInFavorites
        itemRating.preference = preference
        return itemRating
    }
    
    func save(rating: ItemRating) {
        let userDefaults = UserDefaults.standard
        guard let item = rating.item, let preference = rating.preference else {
            return
        }
        guard var favorites = userDefaults.array(forKey: "favorites"), var preferences = userDefaults.dictionary(forKey: "preferences") as? [String: Double] else {
            if rating.isFavorite ?? false {
                userDefaults.set([rating.item?.name], forKey: "favorites")
            } else {
                userDefaults.set([], forKey: "favorites")
            }
            let dictionary: [String: Double] = [item.name: preference]
            userDefaults.set(dictionary, forKey: "preferences")
            return
        }
        if rating.isFavorite ?? false {
            favorites.append(rating.item?.name ?? "")
            userDefaults.set(favorites, forKey: "favorites")
        }
        preferences[item.name] = rating.preference
        userDefaults.set(preferences, forKey: "preferences")
    }
}
