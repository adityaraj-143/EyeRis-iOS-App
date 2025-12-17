//
//  TestResultViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 09/12/25.
//

import UIKit

class TestHistoryViewController: UIViewController {
    
    @IBOutlet weak var NVAView: UIView!
    @IBOutlet weak var DVAView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    // Outlets for this screen
    @IBOutlet weak var nextTest: UIButton!
    @IBOutlet weak var prevTest: UIButton!
    @IBOutlet weak var testDate: UILabel!
    
    // NVA
    @IBOutlet weak var NVAHealthyScore: UILabel!
    @IBOutlet weak var NVALeftEyeScore: UILabel!
    @IBOutlet weak var NVARightEyeScore: UILabel!
    
    
    // DVA
    @IBOutlet weak var DVAHealthyScore: UILabel!
    @IBOutlet weak var DVALeftEyeScore: UILabel!
    @IBOutlet weak var DVARightEyeScore: UILabel!
    
    
    // MARK: - Data for this screen
    
    /// Same results, but grouped so that each item = one date (near + distant together)
    private var groupedResultsByDate: [AcuityTestsForADate] = []
    
    /// Which date (index) we are currently showing on screen
    private var currentIndex: Int = 0
    
    /// Formats Date -> "Apr 25, 2025"
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var response = AcuityTestResultResponse()
        groupedResultsByDate = response.groupTestsByDate()
        
        // 2. Start from the most recent date (last in the sorted array)
        if !groupedResultsByDate.isEmpty {
            currentIndex = groupedResultsByDate.count - 1
        }
        
        // 3. Update the labels and buttons for this starting date
        updateUIForCurrentDate()
        
        [NVAView, DVAView, mainView, commentView].forEach {
            $0?.applyCornerRadius()
        }
        [NVAView, DVAView].forEach {
            $0?.applyShadow()
        }
    }
    
}

extension TestHistoryViewController{
    
    func updateUIForCurrentDate() {
        // 1. Safety check – if no data, do nothing
        guard !groupedResultsByDate.isEmpty else { return }
        
        // 2. Get the tests for the current index (current date)
        let testsForDate = groupedResultsByDate[currentIndex]
        
        // 3. Update the date label at the top
        testDate.text = dateFormatter.string(from: testsForDate.date)
        
        // 4. Update Distant Vision (DVA) card
        DVAHealthyScore.text  = "Healthy Score \(testsForDate.distant.heathyScore)"
        DVALeftEyeScore.text  = testsForDate.distant.leftEyeScore
        DVARightEyeScore.text = testsForDate.distant.rightEyeScore
        
        // 5. Update Near Vision (NVA) card
        NVAHealthyScore.text  = "Healthy Score \(testsForDate.near.heathyScore)"
        NVALeftEyeScore.text  = testsForDate.near.leftEyeScore
        NVARightEyeScore.text = testsForDate.near.rightEyeScore
        
        // 6. Enable/disable prev & next buttons based on position
        let isFirst = currentIndex == 0
        let isLast  = currentIndex == groupedResultsByDate.count - 1
        
        prevTest.isEnabled = !isFirst
        nextTest.isEnabled = !isLast
        
        // Optional: fade buttons when disabled
        prevTest.alpha = prevTest.isEnabled ? 1.0 : 0.3
        nextTest.alpha = nextTest.isEnabled ? 1.0 : 0.3
    }
    
    @IBAction func prevTestTapped(_ sender: UIButton) {
        // Move to previous date if possible
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        //        updateUIForCurrentDate() // without animation
        UIView.transition(with: view,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
            self.updateUIForCurrentDate()
        }, completion: nil)
    }
    
    @IBAction func nextTestTapped(_ sender: UIButton) {
        // Move to next date if possible
        guard currentIndex < groupedResultsByDate.count - 1 else { return }
        currentIndex += 1
        //        updateUIForCurrentDate() //without animation
        UIView.transition(with: view,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
            self.updateUIForCurrentDate()
        }, completion: nil)
    }
    
    
}


