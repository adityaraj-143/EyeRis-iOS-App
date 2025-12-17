import UIKit

final class BlinkRateGraphView: UIView {

    // MARK: - Configuration
    private let maxValue: CGFloat = 30
    private let gridStep: CGFloat = 10
    private let barWidth: CGFloat = 18
    private let barCornerRadius: CGFloat = 5
    private let bottomPadding: CGFloat = 14
    private let topPadding: CGFloat = 8
    private let rightLabelPadding: CGFloat = 20
    private let tooltipOffset: CGFloat = 110
    private let gridLineColor = UIColor.systemGray4

    // MARK: - State
    private var barFrames: [CGRect] = []
    private var selectedBarIndex: Int?
    private var currentBarIndex: Int?
    private var currentWeek: BlinkWeek?
    private var isBeingReused = false

    // MARK: - Layers
    private var barLayers: [CAShapeLayer] = []
    private var gridLineLayers: [CAShapeLayer] = []
    private var labelLayers: [CATextLayer] = []
    private var referenceLineLayer: CAShapeLayer?
    private var connectorLineLayer: CAShapeLayer?

    // MARK: - Tooltip
    private var tooltipView: BlinkTooltipView?
    
    // MARK: - Gesture
    private weak var longPressGesture: UILongPressGestureRecognizer?

    // MARK: - Callbacks
    var onBarSelectionStarted: (() -> Void)?
    var onBarSelectionEnded: (() -> Void)?

    private var currentScreenScale: CGFloat {
        window?.windowScene?.screen.scale ?? traitCollection.displayScale
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGesture()
    }

    // MARK: - Public API
    func configure(week: BlinkWeek) {
        isBeingReused = false
        isUserInteractionEnabled = true

        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        barLayers.removeAll()
        gridLineLayers.removeAll()
        labelLayers.removeAll()
        referenceLineLayer = nil
        barFrames.removeAll()
        
        tooltipView?.removeFromSuperview()
        tooltipView = nil
        
        connectorLineLayer?.removeFromSuperlayer()
        connectorLineLayer = nil
        

        longPressGesture?.isEnabled = false
        selectedBarIndex = nil
        longPressGesture?.isEnabled = true

        layoutIfNeeded()
        currentWeek = week

        let newTooltip = BlinkTooltipView()
        newTooltip.configure()
        addSubview(newTooltip)
        tooltipView = newTooltip

        let values = week.days.map { $0?.bpm ?? 0 }
        let todayIndex = week.days.firstIndex {
            guard let date = $0?.performedOn else { return false }
            return Calendar.current.isDateInToday(date)
        }
        currentBarIndex = todayIndex
        drawGrid()
        drawBars(values: values, highlightIndex: todayIndex)
        drawReferenceLine(at: 20)
    }
    
    func resetForReuse() {
        isBeingReused = true
        
        longPressGesture?.isEnabled = false
        
        onBarSelectionStarted = nil
        onBarSelectionEnded = nil
        
        selectedBarIndex = nil
        currentWeek = nil
        barFrames.removeAll()

        tooltipView?.removeFromSuperview()
        tooltipView = nil
        
        connectorLineLayer?.removeFromSuperlayer()
        connectorLineLayer = nil
        
        longPressGesture?.isEnabled = true
    }

    // MARK: - Drawing
    private func drawGrid() {
        stride(from: 0, through: maxValue, by: gridStep).forEach { value in
            guard value != 20 else { return }

            let y = yPosition(for: value)
            let endX = bounds.width - rightLabelPadding

            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: endX, y: y))

            let line = CAShapeLayer()
            line.path = path.cgPath
            line.strokeColor = gridLineColor.cgColor
            line.lineWidth = 1
            line.contentsScale = currentScreenScale

            layer.addSublayer(line)
            gridLineLayers.append(line)

            let label = CATextLayer()
            label.string = "\(Int(value))"
            label.fontSize = 12
            label.foregroundColor = UIColor.systemGray.cgColor
            label.contentsScale = currentScreenScale
            label.frame = CGRect(x: bounds.width - 12, y: y - 8, width: 30, height: 16)

            layer.addSublayer(label)
            labelLayers.append(label)
        }
    }

    private func drawBars(values: [Int], highlightIndex: Int?) {
        guard values.count == 7 else { return }

        let usableHeight = bounds.height - bottomPadding - topPadding
        let spacing = (bounds.width - barWidth * 7) / 8

        for (index, value) in values.enumerated() {
            guard value > 0 else {
                barFrames.append(.zero)
                continue
            }

            let barHeight = (CGFloat(value) / maxValue) * usableHeight
            let x = spacing + CGFloat(index) * (barWidth + spacing)
            let y = bounds.height - bottomPadding - barHeight

            let rect = CGRect(x: x, y: y, width: barWidth, height: barHeight)
            barFrames.append(rect)

            let layer = CAShapeLayer()
            layer.path = topRoundedPath(rect: rect, radius: barCornerRadius).cgPath
            layer.fillColor = barColor(for: index, highlightIndex: highlightIndex).cgColor
            layer.contentsScale = currentScreenScale
            layer.opacity = 0

            let fade = CABasicAnimation(keyPath: "opacity")
            fade.fromValue = 0
            fade.toValue = 1
            fade.duration = 0.25
            fade.timingFunction = CAMediaTimingFunction(name: .easeOut)
            layer.add(fade, forKey: nil)
            layer.opacity = 1

            self.layer.addSublayer(layer)
            barLayers.append(layer)
        }
    }

    private func drawReferenceLine(at value: CGFloat) {
        let y = yPosition(for: value)
        let endX = bounds.width - rightLabelPadding

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: y))
        path.addLine(to: CGPoint(x: endX, y: y))

        let line = CAShapeLayer()
        line.path = path.cgPath
        line.strokeColor = UIColor.systemGreen.cgColor
        line.lineDashPattern = [4, 4]
        line.contentsScale = currentScreenScale

        layer.addSublayer(line)
        referenceLineLayer = line
    }

    private func drawConnectorLine(from barFrame: CGRect) {
        guard !isBeingReused, let tooltip = tooltipView else { return }
        
        connectorLineLayer?.removeFromSuperlayer()

        let startPoint = CGPoint(x: barFrame.midX, y: barFrame.minY)
        let endPoint = CGPoint(x: tooltip.center.x, y: tooltip.frame.maxY)

        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)

        let line = CAShapeLayer()
        line.path = path.cgPath
        line.strokeColor = UIColor.systemBlue.cgColor
        line.lineWidth = 2
        line.lineCap = .round
        line.contentsScale = currentScreenScale
        line.strokeEnd = 0

        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.duration = 0.25
        drawAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        line.add(drawAnimation, forKey: "drawLine")
        line.strokeEnd = 1

        layer.addSublayer(line)
        connectorLineLayer = line
    }

    // MARK: - Gesture Handling
    private func setupGesture() {
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(_:))
        )
        longPress.minimumPressDuration = 0.3
        addGestureRecognizer(longPress)
        longPressGesture = longPress
    }

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard !isBeingReused,
              window != nil,
              superview != nil,
              currentWeek != nil,
              !barFrames.isEmpty else { return }
        
        let location = gesture.location(in: self)

        switch gesture.state {
        case .began, .changed:
            guard let index = barFrames.firstIndex(where: { $0.contains(location) }),
                  selectedBarIndex != index else { return }

            selectedBarIndex = index
            updateBarSelection(selectedIndex: index)
            onBarSelectionStarted?()

            if let week = currentWeek, !isBeingReused {
                tooltipView?.show(for: index, week: week, barFrame: barFrames[index], offset: tooltipOffset)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
                    guard let self = self, !self.isBeingReused else { return }
                    self.drawConnectorLine(from: self.barFrames[index])
                }
            }

        default:
            guard !isBeingReused else { return }
            
            selectedBarIndex = nil
            updateBarSelection(selectedIndex: currentBarIndex)
            tooltipView?.hide()
            
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.connectorLineLayer?.opacity = 0
            } completion: { [weak self] _ in
                self?.connectorLineLayer?.removeFromSuperlayer()
                self?.connectorLineLayer = nil
            }
            
            onBarSelectionEnded?()
        }
    }

    private func updateBarSelection(selectedIndex: Int?) {
        guard !isBeingReused else { return }
        
        for (i, layer) in barLayers.enumerated() {
            let targetColor = (i == selectedIndex ? UIColor.systemBlue : .lightBlue).cgColor
            
            let colorAnimation = CABasicAnimation(keyPath: "fillColor")
            colorAnimation.toValue = targetColor
            colorAnimation.duration = 0.2
            colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            layer.add(colorAnimation, forKey: "colorChange")
            layer.fillColor = targetColor
        }
    }

    // MARK: - Helpers
    private func yPosition(for value: CGFloat) -> CGFloat {
        let usableHeight = bounds.height - bottomPadding - topPadding
        let y = bounds.height - bottomPadding - (value / maxValue) * usableHeight
        return min(bounds.height - bottomPadding, max(topPadding, y))
    }

    private func barColor(for index: Int, highlightIndex: Int?) -> UIColor {
        index == highlightIndex ? .systemBlue : .lightBlue
    }

    private func topRoundedPath(rect: CGRect, radius: CGFloat) -> UIBezierPath {
        UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
    }
}
