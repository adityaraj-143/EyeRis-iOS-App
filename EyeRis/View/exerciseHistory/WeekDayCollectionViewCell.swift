import UIKit

class WeekdayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var weekdayButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.clipsToBounds = true
        weekdayButton.titleLabel?.textAlignment = .center

        // Button is visual only
        weekdayButton.isUserInteractionEnabled = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = min(mainView.bounds.width, mainView.bounds.height) / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        applyStyle(hasExercise: false, isSelected: false)
        weekdayButton.setTitle(nil, for: .normal)
    }

    /// Configures the cell with two independent states:
    /// - hasExercise: data-driven (exercise performed)
    /// - isSelected: user-driven (currently selected day)
    func configureCell(letter: String,
                       hasExercise: Bool,
                       isSelected: Bool) {

        weekdayButton.setTitle(letter, for: .normal)
        applyStyle(hasExercise: hasExercise, isSelected: isSelected)
    }

    private func applyStyle(hasExercise: Bool, isSelected: Bool) {

        switch (hasExercise, isSelected) {

        case (true, true):
            // Selected + has exercise
            mainView.backgroundColor = .systemBlue
            weekdayButton.setTitleColor(.white, for: .normal)

        case (true, false):
            // Has exercise but not selected
            mainView.backgroundColor = .systemBlue.withAlphaComponent(0.15)
            weekdayButton.setTitleColor(.systemBlue, for: .normal)

        case (false, true):
            // Selected but no exercise
            mainView.backgroundColor = .systemGray
            weekdayButton.setTitleColor(.white, for: .normal)

        case (false, false):
            // Normal state
            mainView.backgroundColor = .white
            weekdayButton.setTitleColor(.black, for: .normal)
        }
    }
}
