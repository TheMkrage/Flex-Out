//
//  GetPrefencesStore.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit
import Networking
import Alamofire

struct GetPrefencesStore {
    static var shared = GetPrefencesStore()
    private init() { }
    
    func getPreferences(balance: String, isOnlyUsingFavorites: Bool, callback: @escaping ([[Item]]) -> Void) {
        var preferences = [[String: String]]()
        for pref in ItemRatingStore.shared.getLocalPreferences(isFavoritesOnly: isOnlyUsingFavorites) {
            var dict = [String: String]()
            dict["name"] = pref.name
            dict["preference"] = pref.preference
            preferences.append(dict)
        }
        Alamofire.request("https://flex-mudd.herokuapp.com/preferences", method: .post, parameters: ["balance": balance, "prefs": preferences], encoding: JSONEncoding.default).responseJSON { (data) in
            let jsonDecoder = JSONDecoder()
            print(data.result.value)
            var newOuterArray = [[Item]]()
            let outerArray = data.result.value as? Array<Array<Any>>
            for innerArray in outerArray! {
                var newInner = [Item]()
                for i in innerArray {
                    var item = Item(price: "0", name: (i as! [String: Any?])["name"] as! String, calories: "0")
                    newInner.append(item)
                }
                newOuterArray.append(newInner)
            }
            //let items = try! jsonDecoder.decode(Array<Array<Item>>.self,from: data.data!)
            callback(newOuterArray)
        }
    }
}
