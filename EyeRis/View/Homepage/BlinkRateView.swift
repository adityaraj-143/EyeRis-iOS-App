import UIKit

class BlinkRateView: UIView {

    // MARK: - Layers & Views
    private let gradientLayer = CAGradientLayer()
    private let pointerImageView = UIImageView()
    private let bpmLabel = UILabel()
    private let minLabel = UILabel()
    private let maxLabel = UILabel()

    // MARK: - Values
    var minValue: CGFloat = 0
    var maxValue: CGFloat = 22

    var value: CGFloat = 9 {
        didSet { updatePointer() }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup
    private func setup() {

        // ---------- GRADIENT ----------
        gradientLayer.colors = [
            UIColor(hex: "FF383C").cgColor,
            UIColor(hex: "FF8000").cgColor,
            UIColor(hex: "FFD400").cgColor,
            UIColor(hex: "1AE62B").cgColor,
            UIColor(hex: "1BEC2C").cgColor
        ]

        gradientLayer.locations = [
            0.42,
            0.48,
            0.69,
            0.82,
            0.97
        ]

        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)

        layer.addSublayer(gradientLayer)

        // ---------- POINTER ----------
        pointerImageView.image = UIImage(systemName: "triangle")?
            .withRenderingMode(.alwaysTemplate)
        pointerImageView.contentMode = .scaleAspectFit
        pointerImageView.transform = CGAffineTransform(rotationAngle: .pi)
        addSubview(pointerImageView)

        // ---------- BPM LABEL ----------
        bpmLabel.textAlignment = .center
        addSubview(bpmLabel)

        // ---------- MIN / MAX LABEL ----------
        minLabel.text = "0"
        minLabel.font = .systemFont(ofSize: 13)
        minLabel.textColor = UIColor.gray.withAlphaComponent(0.55)
        addSubview(minLabel)

        maxLabel.text = "22"
        maxLabel.font = .systemFont(ofSize: 13)
        maxLabel.textColor = UIColor.gray.withAlphaComponent(0.55)
        addSubview(maxLabel)
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        let barHeight: CGFloat = 8
        let barWidth: CGFloat = bounds.width * 0.85
        let barX = (bounds.width - barWidth) / 2
        let barY = bounds.height - 25

        gradientLayer.frame = CGRect(
            x: barX,
            y: barY,
            width: barWidth,
            height: barHeight
        )
        gradientLayer.cornerRadius = barHeight / 2

        minLabel.frame = CGRect(
            x: barX - 6,
            y: barY - 22,
            width: 30,
            height: 18
        )

        maxLabel.frame = CGRect(
            x: barX + barWidth,
            y: barY - 22,
            width: 30,
            height: 18
        )

        updatePointer()
    }

    // MARK: - Update UI
    private func updatePointer() {

        let bar = gradientLayer.frame
        let pos = max(0, min(1, (value - minValue) / (maxValue - minValue)))
        let x = bar.minX + pos * bar.width

        let triW: CGFloat = 16
        let triH: CGFloat = 12
        let topY = bar.minY - 2

        pointerImageView.frame = CGRect(
            x: x - triW / 2,
            y: topY - triH,
            width: triW,
            height: triH
        )

        let color = gradientColor(at: pos)
        pointerImageView.tintColor = color

        let number = "\(Int(value))"
        let unit = " bpm"

        let attributed = NSMutableAttributedString(
            string: number,
            attributes: [
                .font: UIFont.systemFont(ofSize: 28, weight: .regular),
                .foregroundColor: color
            ]
        )

        attributed.append(
            NSAttributedString(
                string: unit,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 9, weight: .regular),
                    .foregroundColor: color
                ]
            )
        )

        bpmLabel.attributedText = attributed
        bpmLabel.sizeToFit()
        bpmLabel.center = CGPoint(x: x, y: topY - triH - 16)
    }

    // MARK: - Gradient Color Sampling
    private func gradientColor(at position: CGFloat) -> UIColor {

        guard
            let colors = gradientLayer.colors as? [CGColor],
            let locations = gradientLayer.locations as? [CGFloat]
        else {
            return .red
        }

        for i in 0..<(locations.count - 1) {
            let start = locations[i]
            let end = locations[i + 1]

            if position >= start && position <= end {
                let progress = (position - start) / (end - start)
                let c1 = UIColor(cgColor: colors[i])
                let c2 = UIColor(cgColor: colors[i + 1])
                return c1.interpolate(to: c2, progress: progress)
            }
        }

        return UIColor(cgColor: colors.last!)
    }
}

// MARK: - UIColor Helpers
extension UIColor {

    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        self.init(
            red: CGFloat((int >> 16) & 0xFF) / 255,
            green: CGFloat((int >>  8) & 0xFF) / 255,
            blue: CGFloat((int >>  0) & 0xFF) / 255,
            alpha: 1
        )
    }

    func interpolate(to color: UIColor, progress: CGFloat) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(
            red: r1 + (r2 - r1) * progress,
            green: g1 + (g2 - g1) * progress,
            blue: b1 + (b2 - b1) * progress,
            alpha: a1 + (a2 - a1) * progress
        )
    }
}
