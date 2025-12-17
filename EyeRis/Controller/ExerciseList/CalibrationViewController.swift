import UIKit
import ARKit
import RealityKit

class CalibrationViewController: UIViewController {
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var cameraFeedBorderView: UIView!
    
    @IBOutlet weak var proceedButton: UIButton!
    
    @IBOutlet weak var cameraContainer: UIView!
    
    private var currentDistance: Int = 0
    private var arSession: ARSession?
    private var arView: ARView?
    private var updateTimer: Timer?
    private let minDistance: Int = 37
    private let maxDistance: Int = 45
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Calibration"
        setupBorderView()
        setupARView()
        setupARKit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard ARFaceTrackingConfiguration.isSupported else { return }
        
        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = false
        arSession?.run(config)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arSession?.pause()
    }
    
    deinit {
        updateTimer?.invalidate()
    }
    
    // MARK: Setup
    
    private func setupBorderView() {
        cameraFeedBorderView.layer.cornerRadius = 17
        cameraFeedBorderView.layer.borderWidth = 5
        cameraFeedBorderView.layer.borderColor = UIColor.systemRed.cgColor
        cameraFeedBorderView.clipsToBounds = true
        cameraContainer.layer.cornerRadius = 17
        cameraFeedBorderView.clipsToBounds = true
    }
    
    private func setupARView() {
        let arView = ARView(frame: cameraContainer.bounds)
        self.arView = arView
        cameraContainer.addSubview(arView)
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: cameraContainer.topAnchor),
            arView.bottomAnchor.constraint(equalTo: cameraContainer.bottomAnchor),
            arView.leadingAnchor.constraint(equalTo: cameraContainer.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: cameraContainer.trailingAnchor)
        ])
    }
    
    private func setupARKit() {
        guard ARFaceTrackingConfiguration.isSupported else {
            showARNotSupportedAlert()
            return
        }
        
        arSession = ARSession()
        arSession?.delegate = self
        arView?.session = arSession!

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = false

        if let session = arSession {
            session.run(config)
        }
        startDistanceUpdates()
    }
    
    // MARK: Distance Detection
    
    private func startDistanceUpdates() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateDistanceMeasurement()
        }
    }
    
    private func updateDistanceMeasurement() {
        guard let frame = arSession?.currentFrame else { return }
        
        let faceAnchors = frame.anchors.compactMap { $0 as? ARFaceAnchor }
        
        if let faceAnchor = faceAnchors.first {
            let z = faceAnchor.transform.columns.3.z
            let distanceInMeters = abs(z)
            currentDistance = Int(distanceInMeters * 100)
            
            currentDistance = max(20, min(100, currentDistance))
            updateUI()
        } else {
            currentDistance = 0
            statusLabel.text = "No face detected"
            statusLabel.textColor = .systemRed
            proceedButton.isEnabled = false
            proceedButton.alpha = 0.5
            cameraFeedBorderView.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    private func updateUI() {
        distanceLabel.text = "\(currentDistance)cm"
        
        let isInRange = currentDistance >= minDistance && currentDistance <= maxDistance
        
        distanceLabel.textColor = isInRange ? .systemGreen : .systemRed
        
        if currentDistance < minDistance {
            statusLabel.text = "Move device away"
            statusLabel.textColor = .systemRed
        } else if currentDistance > maxDistance {
            statusLabel.text = "Move device closer"
            statusLabel.textColor = .systemRed
        } else {
            statusLabel.text = "Perfect distance!"
            statusLabel.textColor = .systemGreen
        }
        
        let borderColor = isInRange ? UIColor.systemGreen : UIColor.systemRed
        UIView.animate(withDuration: 0.3) {
            self.cameraFeedBorderView.layer.borderColor = borderColor.cgColor
        }
        
        proceedButton.isEnabled = isInRange
        proceedButton.alpha = isInRange ? 1.0 : 0.5
    }
    
    // MARK: Actions
    
    @IBAction func proceedButtonTapped(_ sender: UIButton) {
        guard let exercise = exercise else { return }
        
        let alert = UIAlertController(
            title: "Ready?",
            message: "Start \(exercise.name)?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Start", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showARNotSupportedAlert() {
        let alert = UIAlertController(
            title: "AR Not Supported",
            message: "Device doesn't support face tracking.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
}

// MARK: AR Session Delegate

extension CalibrationViewController: ARSessionDelegate {
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("AR error: \(error)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("AR interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("AR resumed")
    }
}
