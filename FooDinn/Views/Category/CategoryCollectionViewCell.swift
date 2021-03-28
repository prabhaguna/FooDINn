//
//  CategoryCollectionViewCell.swift
//  FooDinn
//
//  Created by devMac02 on 24/03/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    static let nibName = "CategoryCollectionViewCell"
    
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithMenu(isSelected : Bool, category : Category) {
        DispatchQueue.main.async {
            self.updateColor(isSelected: isSelected)
            self.lblName.text = category.name ?? ""
        }
    }
    
    func updateColor(isSelected : Bool) {
        DispatchQueue.main.async {
            if(isSelected) {
               self.lblName.textColor = UIColor.black
            } else {
                self.lblName.textColor = UIColor.lightGray
            }
        }
    }

}
