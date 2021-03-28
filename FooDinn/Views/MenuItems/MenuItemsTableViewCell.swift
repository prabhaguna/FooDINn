//
//  MenuItemsTableViewCell.swift
//  FooDinn
//
//  Created by devMac02 on 24/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class MenuItemsTableViewCell: UITableViewCell {
    
    static let identifier = "MenuItemsCell"
    static let nibName = "MenuItemsTableViewCell"

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgMenuItem: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var viewBg: UIView!
    private let disposeBag = DisposeBag()
    var menuItemsProtocol : MenuItemsViewProtocol?
    var menuItem : MenuItems?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnAdd.rx.tap.subscribe { [weak self] event in
          guard let self = self else { return }
          if let mprotocol = self.menuItemsProtocol {
            mprotocol.selectedMenuItems.onNext(self.menuItem!)
          }
          self.updateBtnAdd(isfromAdd: true)
        }.disposed(by: disposeBag)
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureWithItem(row : Int,
                           menuItemsProtocol : MenuItemsViewProtocol,
                           menuItem : MenuItems) {
                           
        DispatchQueue.main.async {
            self.menuItemsProtocol = menuItemsProtocol
            self.imgMenuItem.image = UIImage(named: menuItem.img ?? "")
            self.lblName.text = menuItem.name ?? ""
            
            if let ingredients = menuItem.ingredients {
                self.lblDesc.text = ingredients.joined(separator: ",")
            }
            
            self.lblDetails.text = (menuItem.weight ?? "") + " " +  (menuItem.size ?? "")
            
      
            self.viewBg.layer.cornerRadius = 5
            self.menuItem = menuItem
            self.btnAdd.tag = row
            self.updateBtnAdd(isfromAdd: false)
        }
    }
    
    func updateBtnAdd(isfromAdd : Bool) {
        DispatchQueue.main.async { [self] in
            if (menuItem!.OrderedCount > 0 || isfromAdd) {
                self.btnAdd.setTitle("added +\(menuItem!.OrderedCount)", for: .normal)
                self.btnAdd.backgroundColor = UIColor.green
            } else {
                let priceString = "\(menuItem!.price ?? 0)" + " " + (menuItem!.currency ?? "")
                self.btnAdd.setTitle(priceString, for: .normal)
                self.btnAdd.backgroundColor = UIColor.black
            }
            self.btnAdd.layer.cornerRadius = 5
        }
    }
}
