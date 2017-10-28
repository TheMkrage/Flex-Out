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
        /*var preferences = [[String: String]]()
        for pref in ItemRatingStore.shared.getLocalPreferences() {
            var dict = [String: String]()
            dict["name"] = pref.name
            dict["preference"] = pref.preference
            preferences.append(dict)
        }
        let json: [String: Any] = ["balance": balance, "prefs": preferences]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        print(jsonData)
        
        // create post request
        let url = URL(string: "https://flex-mudd.herokuapp.com/preferences")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()*/
        
        /*let networking = Networking(baseURL: "https://flex-mudd.herokuapp.com")
        print(ItemRatingStore.shared.getLocalPreferences())
        let jsonEncoder = JSONEncoder()
        let encoding = try! jsonEncoder.encode(ItemRatingStore.shared.getLocalPreferences())
        
        var preferences = [[String: String]]()
        for pref in ItemRatingStore.shared.getLocalPreferences() {
            var dict = [String: String]()
            dict["name"] = pref.name
            dict["preference"] = pref.preference
            preferences.append(dict)
        }
        
        networking.post("/preferences", parameters: ["balance": balance, "prefs": preferences], parts: []) { (result) in
            switch result {
            case .success(let response):
                let body = response.dictionaryBody
            // Do something with headers
            case .failure(let response): break
                // Handle error
            }
        }*/
        var preferences = [[String: String]]()
        for pref in ItemRatingStore.shared.getLocalPreferences() {
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
                    var item = Item(price: "0", name: i.name, calories: "0")
                    item.name = i["name"]
                    newInner.append(item)
                }
                newOuterArray.append(newInner)
            }
            let items = try! jsonDecoder.decode(Array<Array<Item>>.self,from: data.data!)
            callback(items)
        }
    }
}
