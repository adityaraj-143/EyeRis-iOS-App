import UIKit

class BlinkRateView: UIView {

    private let gradientLayer = CAGradientLayer()
    private let pointer = CAShapeLayer()
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
        // Gradient bar
        gradientLayer.colors = [
            UIColor.systemRed.cgColor,
            UIColor.systemYellow.cgColor,
            UIColor.systemGreen.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 5
        layer.addSublayer(gradientLayer)

        // Pointer (triangle)
        pointer.fillColor = UIColor.systemRed.cgColor
        layer.addSublayer(pointer)

        // BPM Label
        bpmLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        bpmLabel.textColor = .systemRed
        bpmLabel.textAlignment = .center
        addSubview(bpmLabel)

        // Min
        minLabel.text = "0"
        minLabel.font = UIFont.systemFont(ofSize: 13)
        minLabel.textColor = .secondaryLabel
        addSubview(minLabel)

        // Max
        maxLabel.text = "22"
        maxLabel.font = UIFont.systemFont(ofSize: 13)
        maxLabel.textColor = .secondaryLabel
        addSubview(maxLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let barHeight: CGFloat = 12
        let pointerSize: CGFloat = 16

        // -------- Gradient Bar --------
        gradientLayer.frame = CGRect(
            x: 0,
            y: bounds.height - barHeight - 10,   // move bar UP
            width: bounds.width,
            height: barHeight
        )
        gradientLayer.cornerRadius = barHeight / 2

        // -------- Min / Max Labels --------
        minLabel.frame = CGRect(
            x: 0,
            y: gradientLayer.frame.minY - 20,
            width: 30,
            height: 18
        )

        maxLabel.frame = CGRect(
            x: bounds.width - 30,
            y: gradientLayer.frame.minY - 20,
            width: 30,
            height: 18
        )

        // -------- Pointer + BPM Label --------
        updatePointer(pointerSize: pointerSize)
    }


    private func updatePointer(pointerSize: CGFloat = 14, labelSpacing: CGFloat = 2) {

        let pos = (value - minValue) / (maxValue - minValue)
        let x = pos * bounds.width

        let barTop = gradientLayer.frame.minY

        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: barTop - 2))
        path.addLine(to: CGPoint(x: x - pointerSize/2, y: barTop - pointerSize))
        path.addLine(to: CGPoint(x: x + pointerSize/2, y: barTop - pointerSize))
        path.close()
        pointer.path = path.cgPath

        // --- BPM LABEL (just above the pointer) ---
        bpmLabel.text = "\(Int(value)) bpm"
        bpmLabel.sizeToFit()

        bpmLabel.frame = CGRect(
            x: x - bpmLabel.frame.width / 2,
            y: (barTop - pointerSize) - bpmLabel.frame.height - labelSpacing,
            width: bpmLabel.frame.width,
            height: bpmLabel.frame.height
        )
    }


}
