//
//  BlinkRateCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class BlinkRateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var blinkRateSliderView: BlinkRateView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var commentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        MainView.layer.cornerRadius = 17
        commentView.layer.cornerRadius = 17
    }

}
