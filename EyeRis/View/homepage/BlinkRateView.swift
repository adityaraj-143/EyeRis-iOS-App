import UIKit

class BlinkRateView: UIView {

    private let gradientLayer = CAGradientLayer()
    private let pointerImageView = UIImageView()
    private let bpmLabel = UILabel()
    private let minLabel = UILabel()
    private let maxLabel = UILabel()

    var minValue: CGFloat = 0
    var maxValue: CGFloat = 22

    var value: CGFloat = 9 {
        didSet { updatePointer() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {

        // ---------- GRADIENT ----------
        gradientLayer.colors = [
            UIColor(hex: "FF383C").cgColor, // red
            UIColor(hex: "FF8000").cgColor, // orange
            UIColor(hex: "FFD400").cgColor, // yellow
            UIColor(hex: "1AE62B").cgColor, // green
            UIColor(hex: "1BEC2C").cgColor  // lime green
        ]

        gradientLayer.locations = [
            0.42,
            0.48,
            0.69,
            0.82,
            0.97
        ]

        // FORCE horizontal gradient — fixes your issue
        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)

        layer.addSublayer(gradientLayer)


        // ---------- POINTER (SF SYMBOL) ----------
        pointerImageView.image = UIImage(systemName: "triangle")?
            .withRenderingMode(.alwaysTemplate)
        pointerImageView.tintColor = UIColor(hex: "FF3B30")
        pointerImageView.contentMode = .scaleAspectFit
        pointerImageView.transform = CGAffineTransform(rotationAngle: .pi) // upside down
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


    override func layoutSubviews() {
        super.layoutSubviews()

        let barHeight: CGFloat = 8
        let barWidth: CGFloat = bounds.width * 0.85
        let barX = (bounds.width - barWidth) / 2

        // Lowered as you requested
        let barY = bounds.height - 25

        gradientLayer.frame = CGRect(
            x: barX,
            y: barY,
            width: barWidth,
            height: barHeight
        )
        gradientLayer.cornerRadius = barHeight / 2

        // MIN / MAX ABOVE BAR
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


    private func updatePointer() {

        let bar = gradientLayer.frame
        let pos = (value - minValue) / (maxValue - minValue)
        let x = bar.minX + pos * bar.width

        let triW: CGFloat = 16
        let triH: CGFloat = 12
        let topY = bar.minY - 2

        // POINTER POSITION
        pointerImageView.frame = CGRect(
            x: x - triW / 2,
            y: topY - triH,
            width: triW,
            height: triH
        )

        // -------- BPM LABEL WITH TWO FONT SIZES --------
        let number = "\(Int(value))"
        let unit = " bpm"

        let attributed = NSMutableAttributedString(
            string: number,
            attributes: [
                .font: UIFont.systemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor(hex: "FF3B30")
            ]
        )

        attributed.append(NSAttributedString(
            string: unit,
            attributes: [
                .font: UIFont.systemFont(ofSize: 9, weight: .regular),
                .foregroundColor: UIColor(hex: "FF3B30")
            ]
        ))

        bpmLabel.attributedText = attributed
        bpmLabel.sizeToFit()
        bpmLabel.center = CGPoint(x: x, y: topY - triH - 16)
    }
}


// ---------- HEX UTILITY ----------
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0; Scanner(string: hex).scanHexInt64(&int)
        self.init(
            red: CGFloat((int >> 16) & 0xFF) / 255,
            green: CGFloat((int >>  8) & 0xFF) / 255,
            blue: CGFloat((int >>  0) & 0xFF) / 255,
            alpha: 1
        )
    }
}
