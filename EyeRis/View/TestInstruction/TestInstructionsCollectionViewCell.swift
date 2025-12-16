//
//  TestInstructionsCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

class TestInstructionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var instructionImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainView.applyCornerRadius()
        mainView.applyShadow()
    }
    
    func configureCell(image: String) {        
        instructionImage.image = UIImage(named: image)
    }
}
