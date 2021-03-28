//
//  CategoryView.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol  CategoryViewProtocol {
    var selectedCategory: PublishSubject<Int>  { get }
}

@IBDesignable
final class CategoryView : UIView {
    
    //UI ELEMENTS
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cvMenu: UICollectionView!
    
    //PROTOCOLS
    var categoryProtocol :  CategoryViewProtocol?
    
    var categoryPublisher : PublishSubject<[Category]>?
    var arrCategory : [Category]?
    var selectedCategoryIndex : Int = 0
    
    private let disposeBag = DisposeBag()

    
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
        bundle.loadNibNamed("CategoryView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .white
        initCollectionView()
    }
    
    private func initCollectionView() {
        cvMenu.rx.setDelegate(self).disposed(by: disposeBag)
        let nib = UINib(nibName: CategoryCollectionViewCell.nibName, bundle: nil)
        cvMenu.register(nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    func setMenu(categoryProtocol :  CategoryViewProtocol, arrCategory : PublishSubject<[Category]>){
        self.categoryProtocol = categoryProtocol
        self.categoryPublisher = arrCategory
        setupMenu()
    }
    
    func setupMenu() {
        
        if let menu = self.categoryPublisher {
            menu.subscribe(onNext: { [weak self] arrCategory in
                guard let self = self else { return }
                self.arrCategory = arrCategory
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                     if let mProtocol = self.categoryProtocol {
                        mProtocol.selectedCategory.onNext(self.selectedCategoryIndex)
                     }
                 })
            }).disposed(by: disposeBag)
            
            menu.bind(to: cvMenu
                  .rx
                  .items(cellIdentifier: CategoryCollectionViewCell.identifier,
                         cellType: CategoryCollectionViewCell.self)) { [self]
                          row, menu, cell in
                          cell.configureWithMenu(isSelected:(row == selectedCategoryIndex), category: menu)
                }
                .disposed(by: disposeBag)
            
            cvMenu.rx.itemSelected
               .subscribe(onNext: { [weak self] indexPath in
                    guard let self = self else { return }
                    self.selectedCategoryIndex = indexPath.row
                    if let cell = self.cvMenu!.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                        cell.updateColor(isSelected: (indexPath.row == self.selectedCategoryIndex))
                    }
                    if let cProtocol = self.categoryProtocol {
                        cProtocol.selectedCategory.onNext(indexPath.row)
                    }
            }).disposed(by: disposeBag)
        }
    }
}

extension CategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let menuInfo = self.arrCategory?[indexPath.row] {
            let height = 30.0
            let text = menuInfo.name
            let width = text!.width(withConstrainedHeight: CGFloat(height), font: UIFont.boldSystemFont(ofSize: 22)) + 30
            return CGSize(width: CGFloat(width), height: CGFloat(height))
        }
        return CGSize(width: 100, height: 50)
    }
}
