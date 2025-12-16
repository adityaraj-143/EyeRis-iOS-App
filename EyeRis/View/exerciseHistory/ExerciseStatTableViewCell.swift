//
//  ExerciseStatTableViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit

class ExerciseStatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseAccuracy: UILabel!
    @IBOutlet weak var exerciseSpeed: UILabel!
    
    func configure(with stat: PerformedExerciseStat) {
        exerciseName.text = stat.name
        exerciseAccuracy.text = "\(stat.accuracy)%"
        exerciseSpeed.text = "\(stat.speed)%"
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
