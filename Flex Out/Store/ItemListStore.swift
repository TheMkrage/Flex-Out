//
//  ItemListStore.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit
import Networking

struct ItemListStore {
    static var shared = ItemListStore()
    private init() { }
    
    func getItems() -> [Item] {
        let url = URL(string: "https://flex-mudd.herokuapp.com/prices")!
        let jsonData = try! Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let items = try! jsonDecoder.decode(Array<Item>.self,from: jsonData)
        return items
        
    }
}
