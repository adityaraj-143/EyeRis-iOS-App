//
//  InstructionViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 12/12/25.
//

import UIKit
import AVKit

class InstructionViewController: UIViewController {

    @IBOutlet weak var mainInstructionLabel: UILabel!
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var subInstruction1Label: UILabel!
    @IBOutlet weak var subInstruction2Label: UILabel!
    @IBOutlet weak var subInstruction3Label: UILabel!
    
    
    var exercise: Exercise?
    private var videoPlayer: AVPlayer?
    private var playerViewController: AVPlayerViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        loadExerciseData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoPlayer?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoPlayer?.pause()
    }
    
    
    // MARK: Navigation Setup
    private func setupNavigationBar() {
        guard let exercise = exercise else { return }
        
        //navigation title = exercise name
        title = exercise.instructions.title
    }
    
    // MARK: Data Loading
    private func loadExerciseData() {
        guard let exercise = exercise else { return }
        
        //setting main instruction
        mainInstructionLabel.text = exercise.instructions.description.first ?? "No instructions available"
        
        //setting subinstructions
        let subInstructions = Array(exercise.instructions.description.dropFirst())

        if subInstructions.count > 0 {
            subInstruction1Label.text = "•" + subInstructions[0]
        }
        
        if subInstructions.count > 1 {
            subInstruction2Label.text = "•" + subInstructions[1]
        }
        
        if subInstructions.count > 2 {
            subInstruction3Label.text = "•" + subInstructions[2]
        }
    }
}

