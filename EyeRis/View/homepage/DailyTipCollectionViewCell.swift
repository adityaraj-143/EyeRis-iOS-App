//
//  DailyTipCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class DailyTipCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCornerRadius(mainView)
        headingLabel.font = .systemFont(ofSize: 15, weight: .semibold)
    }

}
