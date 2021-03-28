//
//  MenuItemsView.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol MenuItemsViewProtocol {
    var selectedMenuItems: PublishSubject<MenuItems>  { get }
}


@IBDesignable
final class MenuItemsView : UIView, UIScrollViewDelegate {
    
    //UI ELEMENTS
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tblMenuItems: UITableView!
    
    //PROTOCOLS
    var menuItemsProtocol : MenuItemsViewProtocol?
    
    private let disposebag = DisposeBag()
    var arrMenuItems : PublishSubject<[MenuItems]>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("MenuItemsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .white
        initTableView()
    }
    
    private func initTableView() {
        tblMenuItems.rx.setDelegate(self).disposed(by: disposebag)
        tblMenuItems.register(UINib(nibName: MenuItemsTableViewCell.nibName, bundle: nil),
                              forCellReuseIdentifier: MenuItemsTableViewCell.identifier)
    }
    
    func setMenuItems(menuIndex : Int,
                      categoryProtocol : CategoryViewProtocol,
                      menuItemsProtocol : MenuItemsViewProtocol,
                      arrMenuItems :  PublishSubject<[MenuItems]>!){
        self.menuItemsProtocol = menuItemsProtocol
        setupMenuItemsTable(menuIndex: menuIndex,
                            categoryProtocol: categoryProtocol,
                            arrMenuItems: arrMenuItems)
    }
    
    func setupMenuItemsTable(menuIndex : Int,
                            categoryProtocol : CategoryViewProtocol,
                            arrMenuItems :  PublishSubject<[MenuItems]>!) {
        
        if let menuItems = arrMenuItems, self.arrMenuItems == nil {
            
            self.arrMenuItems = arrMenuItems
            menuItems.bind(to: tblMenuItems
                  .rx
                  .items(cellIdentifier: MenuItemsTableViewCell.identifier,
                         cellType: MenuItemsTableViewCell.self)) {[weak self] row, menuItem, cell in

                        guard let self = self else { return }
                        cell.configureWithItem(row: row, menuItemsProtocol: self.menuItemsProtocol!, menuItem: menuItem)
                }
                .disposed(by: disposebag)
                categoryProtocol.selectedCategory.onNext(menuIndex)
        }
    }

}


extension MenuItemsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
