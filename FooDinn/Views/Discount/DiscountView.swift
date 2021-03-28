//
//  DiscountView.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol DiscountViewProtocol {
    var selectedDiscount: PublishSubject<Int>  { get }
}

@IBDesignable
final class DiscountView : UIView {
    
    //UI ELEMENTS
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cvDiscount: UICollectionView!
    
    //PROTOCOLS
    var discountProtocol : DiscountViewProtocol?
    var arrDiscount : PublishSubject<[Discount]>?

    private let disposebag = DisposeBag()
    
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
        bundle.loadNibNamed("DiscountView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        initCollectionView()
    }
    
    private func initCollectionView() {
        cvDiscount.rx.setDelegate(self).disposed(by: disposebag)
        let nib = UINib(nibName: DiscountCollectionViewCell.nibName, bundle: nil)
        cvDiscount.register(nib, forCellWithReuseIdentifier: DiscountCollectionViewCell.identifier)
        cvDiscount.isPagingEnabled = true
    }
    
    func setDiscount(dProtocol : DiscountViewProtocol, arrDiscount : PublishSubject<[Discount]>!){
        self.discountProtocol = dProtocol
        self.arrDiscount = arrDiscount
        setupDiscount()
    }
    
    func setupDiscount() {
        
        if let discounts = self.arrDiscount {
            discounts.bind(to: cvDiscount
                  .rx
                  .items(cellIdentifier: DiscountCollectionViewCell.identifier,
                         cellType: DiscountCollectionViewCell.self)) {
                          row, discount, cell in
                          cell.configureWithDiscount(discount: discount)
                }
                .disposed(by: disposebag)
            
            cvDiscount.rx.itemSelected
               .subscribe(onNext: { [weak self] indexPath in
                    guard let self = self else { return }
                    if let discountProtocol = self.discountProtocol {
                        discountProtocol.selectedDiscount.onNext(indexPath.row)
                    }
            }).disposed(by: disposebag)
        }
    }

}

extension DiscountView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width , height: self.frame.size.height)
    }
}
