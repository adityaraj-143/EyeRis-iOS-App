//
//  BlinkRateGraphCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit

class BlinkRateGraphCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var weeklyBPM: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var graphView: BlinkRateGraphView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.applyCornerRadius()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        // Clear callbacks FIRST
        graphView.onBarSelectionStarted = nil
        graphView.onBarSelectionEnded = nil
        
        // Then reset the view
        graphView.resetForReuse()
    }
    func configure(with week: BlinkWeek) {
        graphView.configure(week: week)

        graphView.onBarSelectionStarted = { [weak self] in
            guard let self else { return }
            self.weeklyBPM.isHidden = true
            self.weekLabel.isHidden = true
        }

        graphView.onBarSelectionEnded = { [weak self] in
            guard let self else { return }
            self.weeklyBPM.isHidden = false
            self.weekLabel.isHidden = false
        }
        
        let values = week.days.compactMap { $0?.bpm }
        let avg = values.isEmpty ? 0 : values.reduce(0, +) / values.count
        let avgString = "\(avg) "
        let bpmString = "bpm"
        
        if avg <= 10 {
            weeklyBPM.textColor = .red
        }
        if avg > 10 {
            weeklyBPM.textColor = .orange
        }
        if avg >= 20 {
            weeklyBPM.textColor = .green
        }
        
        
        let attributedText = NSMutableAttributedString(
            string: avgString,
            attributes: [
                .font: UIFont.systemFont(ofSize: 28) // adjust to your main font size
            ]
        )

        let bpmAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12)
        ]

        attributedText.append(NSAttributedString(string: bpmString, attributes: bpmAttributes))

        weeklyBPM.attributedText = attributedText
        

        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"

        let start = formatter.string(from: week.startDate)
        let end = formatter.string(
            from: Calendar.current.date(byAdding: .day, value: 6, to: week.startDate)!
        )
        weekLabel.font = .systemFont(ofSize: 12)
        weekLabel.text = "Weekly Average • \(start) – \(end)"
    }

}
