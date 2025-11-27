//
//  DailyTipCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class DailyTipCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 17
    }

}
