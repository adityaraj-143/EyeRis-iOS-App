//
//  BlinkRateViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 26/11/25.
//


import UIKit
import ARKit
import AVFoundation

class BlinkRateViewController: UIViewController, ARSessionDelegate {

    // Invisible AR session
    let session = ARSession()


    @IBOutlet weak var Passage: UILabel!
    
    // Blink state variables
    var isBlinking = false
    var blinkCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        requestCameraPermission { granted in
            if granted {
                self.startFaceTracking()
            } else {
                self.showPermissionAlert()
            }
        }
    }

    // MARK: - CAMERA PERMISSION
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        switch status {

        case .authorized:
            completion(true)

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }

        case .denied:
            completion(false)

        case .restricted:
            completion(false)

        @unknown default:
            completion(false)
        }
    }

    func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Camera Permission Needed",
            message: "Please enable camera access in Settings to use eye tracking.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

    // MARK: - START FACE TRACKING
    func startFaceTracking() {

        guard ARFaceTrackingConfiguration.isSupported else {
            print("Face tracking not supported on this device.")
            return
        }

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true

        session.delegate = self
        session.run(config, options: [])
    }

    // MARK: - AR SESSION DELEGATE
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {

        guard let faceAnchor = anchors.first as? ARFaceAnchor else { return }

        let leftBlink  = faceAnchor.blendShapes[.eyeBlinkLeft]  as? Float ?? 0.0
        let rightBlink = faceAnchor.blendShapes[.eyeBlinkRight] as? Float ?? 0.0

        detectBlink(left: leftBlink, right: rightBlink)
    }

    // MARK: - BLINK DETECTION
    func detectBlink(left: Float, right: Float) {

        let threshold: Float = 0.65
        let isClosed = (left > threshold && right > threshold)

        if isClosed && !isBlinking {
            isBlinking = true
        }

        if !isClosed && isBlinking {
            blinkCount += 1
            isBlinking = false

            
        }
    }
}
