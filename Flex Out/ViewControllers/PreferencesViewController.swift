//
//  PreferencesViewController.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var itemRatings = [ItemRating]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = "Preferences"
        self.navigationItem.title = "f l e x"
        let itemsList = ItemListStore.shared.getItems()
        for item in itemsList {
            var itemRating = ItemRatingStore.shared.getItemRating(with: item.name)
            itemRating.item = item
            itemRatings.append(itemRating)
        }
        self.table.reloadData()
    }
    
    @objc func sliderEnded(sender: UISlider) {
        var itemRating = self.itemRatings[sender.tag]
        itemRating.preference = Double(sender.value)
        ItemRatingStore.shared.save(rating: itemRating)
    }
    
    @objc func favoritedToggle(sender: UIButton) {
        self.itemRatings[sender.tag].isFavorite = !(self.itemRatings[sender.tag].isFavorite ?? false)
        
        if self.itemRatings[sender.tag].isFavorite ?? false {
            sender.setImage(#imageLiteral(resourceName: "Star-Full"), for: .normal)
        } else {
            sender.setImage(#imageLiteral(resourceName: "Star-Empty"), for: .normal)
        }
        ItemRatingStore.shared.save(rating: self.itemRatings[sender.tag])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemRating = self.itemRatings[indexPath.row]
        guard let cell = self.table.dequeueReusableCell(withIdentifier: "preferenceCell") as? PreferenceCellTableViewCell, let item = itemRating.item else {
            return UITableViewCell()
        }
        cell.isUserInteractionEnabled = true
        cell.favoritesButton.isUserInteractionEnabled = true
        cell.slider.value = Float(itemRating.preference ?? 0)
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "$ " + item.price
        cell.calLabel.text = "\(item.calories) cal"
        cell.slider.tag = indexPath.row
        cell.favoritesButton.tag = indexPath.row
        if itemRating.isFavorite ?? false {
            cell.favoritesButton.setImage(#imageLiteral(resourceName: "Star-Full"), for: .normal)
        } else {
            cell.favoritesButton.setImage(#imageLiteral(resourceName: "Star-Empty"), for: .normal)
        }
        cell.slider.addTarget(self, action: #selector(sliderEnded(sender:)), for: [.touchUpInside,.touchUpOutside])
        cell.favoritesButton.addTarget(self, action: #selector(favoritedToggle(sender:)), for: .touchUpInside)
        return cell
    }
    
}
