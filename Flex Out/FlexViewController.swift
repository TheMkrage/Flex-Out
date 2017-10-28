//
//  FlexViewController.swift
//  Flex Out
//
//  Created by Matthew Krager on 10/27/17.
//  Copyright © 2017 Matthew Krager. All rights reserved.
//

import UIKit

class FlexViewController: UIViewController {
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var favoritesCheckbox: UIButton!
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.priceTextField.layer.cornerRadius = 8
        self.priceTextField.layer.borderWidth = 1.0
        self.priceTextField.layer.borderColor = UIColor(hex: "9B9B9B").cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
