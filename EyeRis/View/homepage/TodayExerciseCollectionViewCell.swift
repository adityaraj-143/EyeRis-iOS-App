//
//  TodayExerciseCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class TodayExerciseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var todayExerciseLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCornerRadius(mainView)
        todayExerciseLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        timeLabel.font = .systemFont(ofSize: 15, weight: .bold)
        playButtonOutlet.applyLiquidGlassEffect()
    }

    @IBAction func playButtonAction(_ sender: Any) {
    }
}
