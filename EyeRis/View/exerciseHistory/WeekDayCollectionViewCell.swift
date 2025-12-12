//
//  WeekdayCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 12/12/25.
//

import UIKit

class WeekdayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var weekdayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.clipsToBounds = true
        weekdayLabel.textAlignment = .center
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = min(mainView.bounds.width, mainView.bounds.height) / 2.0
        mainView.layer.cornerRadius = radius
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset any visual state if needed
        // e.g. mainView.backgroundColor = .white
    }

    func configureCell(letter: String, isSelected: Bool) {
        weekdayLabel.text = letter
        // Update selection style
        mainView.backgroundColor = isSelected ? UIColor.systemBlue : UIColor.white
        weekdayLabel.textColor = isSelected ? .white : .black
    }
}
