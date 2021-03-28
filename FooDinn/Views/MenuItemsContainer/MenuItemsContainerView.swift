//
//  MenuItemsContainerView.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa



@IBDesignable
final class MenuItemsContainerView : UIView, UIScrollViewDelegate {
    
    //UI ELEMENTS
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cvContainer: UICollectionView!
    
    //PROTOCOLS
    
    private let disposebag = DisposeBag()
    var arrCategory : PublishSubject<[Category]>?
    var arrCurrentMenuItems : PublishSubject<[MenuItems]>?
    var  categoryProtocol : CategoryViewProtocol?
    
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
        bundle.loadNibNamed("MenuItemsContainerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .white
        initCollectionView()
    }
    
    private func initCollectionView() {
        cvContainer.rx.setDelegate(self).disposed(by: disposebag)
        let nib = UINib(nibName: MenuItemsContainerCollectionViewCell.nibName, bundle: nil)
        cvContainer.register(nib, forCellWithReuseIdentifier: MenuItemsContainerCollectionViewCell.identifier)
        cvContainer.isPagingEnabled = true
    }
    
    func setMenuItemsContainer(categoryProtocol : CategoryViewProtocol,
                               menuItemsProtocol : MenuItemsViewProtocol,
                               arrCategory :  PublishSubject<[Category]>!,
                               arrCurrentMenuItems : PublishSubject<[MenuItems]>!){
       
        self.arrCategory = arrCategory
        self.arrCurrentMenuItems = arrCurrentMenuItems
        self.categoryProtocol =  categoryProtocol
        setupContainer(categoryProtocol: categoryProtocol, menuItemsProtocol: menuItemsProtocol)
    }
    
    func setupContainer(categoryProtocol : CategoryViewProtocol,
                        menuItemsProtocol : MenuItemsViewProtocol) {
        
        if let menu = self.arrCategory {
            menu.bind(to: cvContainer
                  .rx
                  .items(cellIdentifier: MenuItemsContainerCollectionViewCell.identifier,
                         cellType: MenuItemsContainerCollectionViewCell.self)) {
                          row, menu, cell in
                     cell.configureWithMenuItems(menuIndex: row,
                                                 menu: menu,
                                                 categoryProtocol: categoryProtocol,
                                                 menuItemsProtocol: menuItemsProtocol,
                                                 arrCurrentMenuItems: self.arrCurrentMenuItems)
                
                     
            }.disposed(by: disposebag)
            
            cvContainer.rx.itemSelected
               .subscribe(onNext: { [weak self] indexPath in
                    guard let self = self else { return }
                   
            }).disposed(by: disposebag)
        }
    }
    
    func moveToSelectedCategory(index : Int, arrMenuItems :  PublishSubject<[MenuItems]>!) {
        let indexPath = IndexPath(row: index, section: 0)
        /*if let _ = cvContainer.dataSource?.collectionView(cvContainer, cellForItemAt: IndexPath(row: index, section: 0)) {
            cvContainer.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }*/
        cvContainer.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        /*if let cell : MenuItemsContainerCollectionViewCell = cvContainer!.cellForItem(at: indexPath) as? MenuItemsContainerCollectionViewCell {
        
            cell.configureWithMenuItems(menuIndex: index, menu: <#T##Menu#>, menuItemsProtocol: <#T##MenuItemsViewProtocol#>, arrCurrentMenuItems: <#T##PublishSubject<[MenuItems]>!#>)        }*/
    }

}

extension MenuItemsContainerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
}
