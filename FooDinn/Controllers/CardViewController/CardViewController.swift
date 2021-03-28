//
//  CardViewController.swift
//  Medium-popover
//
//  Created by Henry Goodwin on 3/6/19.
//  Copyright © 2019 Henry Goodwin. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

   @IBOutlet weak var handleArea: UIView!
   @IBOutlet weak var viewCategory : CategoryView!
   @IBOutlet weak var viewFilter : FilterView!
   @IBOutlet weak var viewMenuItemsContainer : MenuItemsContainerView!
   @IBOutlet weak var viewCart: UIView!
   @IBOutlet weak var btnCart: UIButton!
   @IBOutlet weak var lblCart: UILabel!
    
   override func viewDidLoad() {
        super.viewDidLoad()
        setupCart()
   }
   
   func setupCart() {
        self.viewCart.backgroundColor = UIColor.clear
        self.btnCart.backgroundColor = UIColor(red: 220.0, green: 220.0, blue: 220.0, alpha: 1.0)
        self.btnCart.layer.cornerRadius = self.btnCart.frame.size.height / 2
        self.lblCart.backgroundColor = UIColor.green
        self.lblCart.layer.cornerRadius = self.lblCart.frame.size.height / 2
        self.lblCart.layer.masksToBounds = true
        self.lblCart.isHidden = true
   }
  
}
