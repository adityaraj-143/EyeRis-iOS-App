//
//  TestInstructionsCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

class TestInstructionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var instructionImage: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainView.applyCornerRadius()
    }
    
}
