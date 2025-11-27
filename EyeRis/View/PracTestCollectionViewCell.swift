//
//  PracTestCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class PracTestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cellCardView2: UIView!
    @IBOutlet weak var cellCardView1: UIView!
    @IBOutlet weak var cellCardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 17
        cellCardView.layer.cornerRadius = 17
        cellCardView1.layer.cornerRadius = 17
        cellCardView2.layer.cornerRadius = 17
    }

}
