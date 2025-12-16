//
//  ExerciseTableViewCell.swift
//  Eyeris Testing
//
//  Created by SDC-USER on 10/12/25.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK: - Properties
    
    // We'll store the exercise so we can track which one this cell represents
    var exercise: Exercise?
    
    // Closure to handle play button tap
    var onPlayTapped: ((Exercise) -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Don't change appearance when selected
    }
    
    // MARK: - Setup
    
    private func setupCell() {
        // Configure labels
        exerciseNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        exerciseNameLabel.textColor = .label
        
        exerciseDurationLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        exerciseDurationLabel.textColor = .secondaryLabel
        
        // Configure play button
        playButton.tintColor = .systemBlue
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Configuration
    
    /// Configure cell with exercise data
    /// - Parameters:
    ///   - exercise: The Exercise object to display
    ///   - onPlay: Callback when play button is tapped
    func configure(with exercise: Exercise, onPlay: @escaping (Exercise) -> Void) {
        self.exercise = exercise
        self.onPlayTapped = onPlay
        
        // Set labels from exercise data
        exerciseNameLabel.text = exercise.name
        
        // Format duration
        let durationText: String
        if exercise.duration >= 60 {
            let minutes = exercise.duration / 60
            durationText = "\(minutes) min"
        } else {
            durationText = "\(exercise.duration) sec"
        }
        exerciseDurationLabel.text = durationText
    }
    
    // MARK: - Actions
    
    @objc private func playButtonTapped() {
        guard let exercise = exercise else { return }
        onPlayTapped?(exercise)
    }
}
