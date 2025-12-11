//
//  BlinkRateCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class BlinkRateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var navigatorButton: UIButton!
    @IBOutlet weak var blinkRateSliderView: BlinkRateView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var commentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCornerRadius([MainView, commentView])
        navigatorButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }

}
