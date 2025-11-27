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
        bpmLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
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

        let barHeight: CGFloat = 10

        // Gradient bar frame
        gradientLayer.frame = CGRect(
            x: 0,
            y: bounds.height - barHeight,
            width: bounds.width,
            height: barHeight
        )

        minLabel.frame = CGRect(
            x: 0,
            y: gradientLayer.frame.minY - 15,
            width: 30,
            height: 14
        )

        maxLabel.frame = CGRect(
            x: bounds.width - 30,
            y: gradientLayer.frame.minY - 15,
            width: 30,
            height: 14
        )

        updatePointer()
    }

    private func updatePointer() {

        let pos = (value - minValue) / (maxValue - minValue)
        let x = pos * bounds.width

        // Triangle
        let size: CGFloat = 12
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x - size/2, y: gradientLayer.frame.minY - size))
        path.addLine(to: CGPoint(x: x + size/2, y: gradientLayer.frame.minY - size))
        path.addLine(to: CGPoint(x: x, y: gradientLayer.frame.minY))
        path.close()
        pointer.path = path.cgPath

        // BPM label
        bpmLabel.text = "\(Int(value)) bpm"
        bpmLabel.frame = CGRect(x: x - 30, y: pointer.frame.minY - 28, width: 60, height: 24)
    }
}
