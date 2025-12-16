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

extension UITableView{
    func applyCornerRadiusToTable(_ radius: CGFloat = 17) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func applyShadowToTable(
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
