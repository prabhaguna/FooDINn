//
//  DiscountCollectionViewCell.swift
//  FooDinn
//
//  Created by Prabhakaran on 23/03/21.
//

import UIKit

class DiscountCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DiscountCell"
    static let nibName = "DiscountCollectionViewCell"

    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithDiscount(discount : Discount) {
        DispatchQueue.main.async {
            self.lblName.text = discount.name ?? ""
            self.lblDesc.text = discount.desc ?? ""
            //self.imgBg.image  = UIImage(named: discount.img ?? "")
            self.viewBg.layer.cornerRadius = self.viewBg.frame.size.height / 2
        }
    }

}
