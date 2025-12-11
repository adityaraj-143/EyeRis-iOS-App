//
//  LastExerciseCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class LastExerciseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var navigatorButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var commentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCornerRadius([mainView,commentView])
        navigatorButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    
    
}
