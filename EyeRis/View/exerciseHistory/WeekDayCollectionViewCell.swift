import UIKit

class WeekdayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var weekdayButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.clipsToBounds = true

        // Button is visual only
        weekdayButton.titleLabel?.textAlignment = .center
        weekdayButton.isUserInteractionEnabled = false
        weekdayButton.setTitleColor(.black, for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let radius = min(mainView.bounds.width, mainView.bounds.height) / 2.0
        mainView.layer.cornerRadius = radius
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        mainView.backgroundColor = .white
        weekdayButton.setTitleColor(.black, for: .normal)
        weekdayButton.setTitle(nil, for: .normal)
    }

    /**
     Configures weekday cell UI.
     If `isSelected` is true, it means at least one exercise
     was performed on that date.
     */
    func configureCell(letter: String, isSelected: Bool) {
        weekdayButton.setTitle(letter, for: .normal)

        mainView.backgroundColor = isSelected ? .systemBlue : .white
        weekdayButton.setTitleColor(isSelected ? .white : .black, for: .normal)
    }
}
