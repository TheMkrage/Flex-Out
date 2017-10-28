//
//  FlexViewController.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class FlexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = self.itemsList[indexPath.row]
        guard let cell = self.table.dequeueReusableCell(withIdentifier: "results") as? ResultsDisplayTableViewCell else {
            return UITableViewCell()
        }
        
        var index = 0
        for item in items {
            cell.labels[index].text = item.name
            cell.labels[index].isHidden = false
            index = index + 1
        }
        while index < 8 {
            cell.labels[index].isHidden = true
            index = index + 1
        }
        return cell
    }
    
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var favoritesCheckbox: UIButton!
    @IBOutlet var table: UITableView!
    
    var isUsingOnlyFavorites = false
    var itemsList = [[Item]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = "flex"
        self.navigationItem.title = "f l e x"
        self.view.isUserInteractionEnabled = true
        self.priceTextField.layer.cornerRadius = 8
        self.priceTextField.layer.borderWidth = 1.0
        self.priceTextField.layer.borderColor = UIColor(hex: "9B9B9B").cgColor
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        button.backgroundColor = UIColor(hex: "FF9200")
        button.setTitle("FLEX", for: .normal)
        self.priceTextField.inputAccessoryView = button
        button.addTarget(self, action: #selector(sendPreferences), for: .touchUpInside)
    }
    
    @objc func sendPreferences() {
        GetPrefencesStore.shared.getPreferences(balance: self.priceTextField.text!, isOnlyUsingFavorites: self.isUsingOnlyFavorites) { (itemsList) in
            self.itemsList = itemsList
        }
    }
    
    @IBAction func tappedView() {
        self.view.endEditing(true)
    }
    
    @IBAction func checkboxTapped() {
        isUsingOnlyFavorites = !isUsingOnlyFavorites
        if isUsingOnlyFavorites {
            self.favoritesCheckbox.setImage(#imageLiteral(resourceName: "Checkbox-Full"), for: .normal)
        } else {
            self.favoritesCheckbox.setImage(#imageLiteral(resourceName: "Checkbox-Empty"), for: .normal)
        }
    }

    
}
