//
//  LastExerciseCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class LastExerciseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var speedPercentage: UILabel!
    @IBOutlet weak var accPercentage: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var navigatorButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var commentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        [mainView,commentView].forEach {
            $0?.applyCornerRadius()
        }
    }
    
    var onTapNavigation: (() -> Void)?
    
    @IBAction func navbutton(_ sender: Any) {
        onTapNavigation?()
    }
    
    func configure(acc: Int, speed: Int) {
        accuracyLabel.text = "\(acc)"
        speedLabel.text = "\(speed)"
        
        accuracyLabel.textColor = color(for: Int(accuracyLabel.text ?? "0")!)
        accPercentage.textColor = accuracyLabel.textColor
        
        speedLabel.textColor = color(for: Int(speedLabel.text ?? "0")!)
        speedPercentage.textColor = speedLabel.textColor
    }
    
    private func color(for value: Int) -> UIColor {
        switch value {
        case 85...100:
            return .green // green
        case 70..<85:
            return .orange   // orange
        default:
            return .red  // red
        }
    }

}

