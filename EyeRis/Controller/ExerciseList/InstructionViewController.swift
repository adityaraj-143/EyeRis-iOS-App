//
//  InstructionViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 12/12/25.
//

import UIKit
import AVKit

// MARK: - Instruction View Controller

/// Displays exercise instructions with video player and sub-instruction details
/// This modal screen shows:
/// - Exercise title in navigation bar
/// - Main instruction text (bold, black)
/// - Sub-instructions as bullet points (3 static labels)
/// - Video player for exercise demonstration
/// - Close button to dismiss
class InstructionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Label displaying the main instruction for the exercise
    @IBOutlet weak var mainInstructionLabel: UILabel!
    
    /// Container view for the video player
    @IBOutlet weak var videoContainerView: UIView!
    
    /// Placeholder view for video (used by AVPlayerViewController)
    @IBOutlet weak var videoPlayerView: UIView!
    
    /// First sub-instruction label
    @IBOutlet weak var subInstruction1Label: UILabel!
    
    /// Second sub-instruction label
    @IBOutlet weak var subInstruction2Label: UILabel!
    
    /// Third sub-instruction label
    @IBOutlet weak var subInstruction3Label: UILabel!
    
    // MARK: - Properties
    
    /// The exercise data passed from the previous screen
    var exercise: Exercise?
    
    /// AVPlayer instance for video playback
    private var videoPlayer: AVPlayer?
    
    /// AVPlayerViewController for video display and controls
    private var playerViewController: AVPlayerViewController?
    
    // MARK: - View Lifecycle
    
    /// Called when view controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        loadExerciseData()
        setupVideoPlayer()
    }
    
    /// Called just before the view controller's view is added to a view hierarchy
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Auto-play video when screen appears
        videoPlayer?.play()
    }
    
    /// Called just before the view controller's view is removed from a view hierarchy
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause video when leaving to save resources
        videoPlayer?.pause()
    }
    
    // MARK: - Navigation Setup
    
    /// Configures the navigation bar with title and close button
    private func setupNavigationBar() {
        guard let exercise = exercise else { return }
        
        // Set the navigation title to exercise name
        title = exercise.instructions.title
        
        // Create close button (×) on the left side
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        closeButton.tintColor = .label
        navigationItem.leftBarButtonItem = closeButton
    }
    
    // MARK: - Data Loading
    
    /// Loads exercise data and populates UI elements
    private func loadExerciseData() {
        guard let exercise = exercise else { return }
        
        // Set main instruction text (first item in description array)
        mainInstructionLabel.text = exercise.instructions.description.first ?? "No instructions available"
        
        // Get all sub-instructions (skip the first one which is the main instruction)
        let subInstructions = Array(exercise.instructions.description.dropFirst())
        
        // Set the three sub-instruction labels
        if subInstructions.count > 0 {
            subInstruction1Label.text = "• " + subInstructions[0]
        }
        
        if subInstructions.count > 1 {
            subInstruction2Label.text = "• " + subInstructions[1]
        }
        
        if subInstructions.count > 2 {
            subInstruction3Label.text = "• " + subInstructions[2]
        }
    }
    
    // MARK: - Video Player Setup
    
    /// Configures and embeds the video player
    /// - Attempts to load video from bundle
    /// - Falls back to placeholder if video not found
    private func setupVideoPlayer() {
        guard let exercise = exercise else { return }
        
        let videoName = exercise.instructions.video
        
        // MARK: Video File Found
        if let videoPath = Bundle.main.path(forResource: videoName, ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: videoPath)
            
            // Create AVPlayer with video URL
            videoPlayer = AVPlayer(url: videoURL)
            
            // Create AVPlayerViewController to handle playback controls
            playerViewController = AVPlayerViewController()
            playerViewController?.player = videoPlayer
            playerViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            
            // Embed player into container
            if let playerVC = playerViewController,
               let playerView = playerVC.view {
                addChild(playerVC)
                videoContainerView.addSubview(playerView)
                
                // Fill container with player view
                NSLayoutConstraint.activate([
                    playerView.leadingAnchor.constraint(equalTo: videoContainerView.leadingAnchor),
                    playerView.trailingAnchor.constraint(equalTo: videoContainerView.trailingAnchor),
                    playerView.topAnchor.constraint(equalTo: videoContainerView.topAnchor),
                    playerView.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor)
                ])
                
                playerVC.didMove(toParent: self)
            }
        }
        // MARK: Video File Not Found
        else {
            // Show placeholder with video name
            let placeholderLabel = UILabel()
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            placeholderLabel.text = "Video: \(videoName)"
//            placeholderLabel.textAlignment = .center
//            placeholderLabel.textColor = .secondaryLabel
//            placeholderLabel.font = UIFont.systemFont(ofSize: 14)
            
            videoContainerView.addSubview(placeholderLabel)
            
            // Center placeholder in container
            NSLayoutConstraint.activate([
                placeholderLabel.centerXAnchor.constraint(equalTo: videoContainerView.centerXAnchor),
                placeholderLabel.centerYAnchor.constraint(equalTo: videoContainerView.centerYAnchor)
            ])
        }
    }
    
    // MARK: - User Actions
    
    /// Handles close button tap - dismisses the modal
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

