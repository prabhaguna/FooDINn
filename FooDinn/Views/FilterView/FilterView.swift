//
//  FilterView.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol FilterViewProtocol {
    var selectedFilter: PublishSubject<Int>  { get }
    var applyFilter: PublishSubject<Void> { get }
}

@IBDesignable
final class FilterView : UIView {
    
    //UI ELEMENTS
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cvFilter: UICollectionView!
    @IBOutlet weak var btnFilter: UIButton!
    
    //PROTOCOLS
    var filterProtocol : FilterViewProtocol?
    
    private let disposeBag = DisposeBag()
    var arrMenuFilters : PublishSubject<[MenuFilters]>?
    var arrFilters : [MenuFilters]?
    
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
        bundle.loadNibNamed("FilterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .white
        initCollectionView()
        
        /*btnFilter.rx.tap.subscribe { [weak self] event in
          guard let self = self else { return }
          if let fprotocol = self.filterProtocol {
            fprotocol.applyFilter.onNext(())
          }
        }.disposed(by: disposeBag)*/
    }
    
    private func initCollectionView() {
        cvFilter.rx.setDelegate(self).disposed(by: disposeBag)
        let nib = UINib(nibName: FilterViewCollectionViewCell.nibName, bundle: nil)
        cvFilter.register(nib, forCellWithReuseIdentifier: FilterViewCollectionViewCell.identifier)
        
        /*if let flowlayout = cvFilter.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }*/
    }
    
    func setMenuFilters(menuFilterProtocol : FilterViewProtocol, arrMenuFilters :  PublishSubject<[MenuFilters]>!){
        self.filterProtocol = menuFilterProtocol
        self.arrMenuFilters = arrMenuFilters
        setupFilters()
    }
    
    func setupFilters() {
        
        if let filters = self.arrMenuFilters {
            
            filters
               .subscribe(onNext: { [weak self] arrFilters in
                guard let self = self else { return }
                self.arrFilters = arrFilters
            }).disposed(by: disposeBag)
     
            filters.bind(to: cvFilter
                  .rx
                  .items(cellIdentifier: FilterViewCollectionViewCell.identifier,
                         cellType: FilterViewCollectionViewCell.self)) {
                          row, filter, cell in
                          cell.configureWithFilter(filter: filter)
                }
                .disposed(by: disposeBag)
            
            cvFilter.rx.itemSelected
               .subscribe(onNext: { [weak self] indexPath in
                
                    guard let self = self else { return }
                    if let fprotocol = self.filterProtocol {
                        fprotocol.selectedFilter.onNext(indexPath.row)
                    }
            }).disposed(by: disposeBag)
        }
    }
    
}

extension FilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let filterInfo = self.arrFilters?[indexPath.row] {
            let height = 30.0
            let text = filterInfo.name
            let width = text!.width(withConstrainedHeight: CGFloat(height), font: UIFont.boldSystemFont(ofSize: 22)) + 10
            return CGSize(width: CGFloat(width), height: 38)
        }
        return CGSize(width: 100, height: 38)
    }
}

extension String {

    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                        options: .usesLineFragmentOrigin,
                                        attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
