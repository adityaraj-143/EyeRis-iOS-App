import UIKit

extension UIView {

    private var liquidGlassTag: Int { return 999123 }  // unique tag

    func applyLiquidGlassEffect() {
        if self.viewWithTag(liquidGlassTag) != nil { return }

        let glassView = RoundUpdatingBlurView()
        glassView.tag = liquidGlassTag
        glassView.translatesAutoresizingMaskIntoConstraints = false

        self.insertSubview(glassView, at: 0)

        NSLayoutConstraint.activate([
            glassView.topAnchor.constraint(equalTo: self.topAnchor),
            glassView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            glassView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        UIView.animate(withDuration: 0.3) {
            glassView.effect = UIBlurEffect(style: .systemThickMaterial)
        }
    }
}

/// Blur view that automatically updates its corner radius when its parent changes size
class RoundUpdatingBlurView: UIVisualEffectView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let parent = superview {
            layer.cornerRadius = parent.layer.cornerRadius
            clipsToBounds = true
        }
    }
}
