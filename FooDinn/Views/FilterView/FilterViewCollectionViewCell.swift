//
//  FilterViewCollectionViewCell.swift
//  FooDinn
//
//  Created by devMac02 on 24/03/21.
//

import UIKit

class FilterViewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FilterCell"
    static let nibName = "FilterViewCollectionViewCell"
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWithFilter(filter : MenuFilters) {
        DispatchQueue.main.async {
            self.lblName.text = filter.name ?? ""
            self.viewBg.layer.cornerRadius = self.viewBg.frame.size.height / 2
            self.viewBg.layer.borderWidth = 1.0
            self.viewBg.layer.borderColor = UIColor.lightGray.cgColor
            self.viewBg.layoutIfNeeded()
        }
    }
}
