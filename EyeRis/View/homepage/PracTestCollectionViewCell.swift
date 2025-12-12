//
//  PracTestCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class PracTestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var tempLabel: UIButton!
    @IBOutlet weak var cellCardView2: UIView!
    @IBOutlet weak var cellCardView1: UIView!
    @IBOutlet weak var cellCardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.applyCornerRadius()
        [cellCardView, cellCardView1, cellCardView2].forEach {
            $0?.applyCornerRadius()
            $0?.applyShadow()
        }
        
        
    }
}
