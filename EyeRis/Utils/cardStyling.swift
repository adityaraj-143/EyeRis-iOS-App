import UIKit

extension UIView {
    
    func applyCornerRadius(_ radius: CGFloat = 17) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func applyShadow(
        color: UIColor = .black,
        opacity: Float = 0.07,
        radius: CGFloat = 6,
        offset: CGSize = .zero
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.masksToBounds = false
    }
}

class CardStyling {
    static func setCornerRadius(view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
    static func setShadows(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }
}
