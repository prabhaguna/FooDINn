//
//  MenuItemsContainerCollectionViewCell.swift
//  FooDinn
//
//  Created by devMac02 on 27/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class MenuItemsContainerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuItemsViewCell"
    static let nibName = "MenuItemsContainerCollectionViewCell"
    @IBOutlet var viewMenuItems : MenuItemsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithMenuItems(menuIndex : Int,
                                menu : Category,
                                categoryProtocol : CategoryViewProtocol,
                                menuItemsProtocol : MenuItemsViewProtocol,
                                arrCurrentMenuItems : PublishSubject<[MenuItems]>!) {
                                
        viewMenuItems.setMenuItems(menuIndex : menuIndex,
                                   categoryProtocol : categoryProtocol,
                                   menuItemsProtocol: menuItemsProtocol,
                                   arrMenuItems: arrCurrentMenuItems)
    }

}
