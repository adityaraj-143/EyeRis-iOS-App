//
//  exListViewController.swift
//  Eyeris Testing
//
//  Created by SDC-USER on 03/12/25.
//

import UIKit

class ExerciseListViewController: UIViewController {
    
    // MARK: - Properties

    private var currentUser: User?  // Store the current user

    // MARK: - Outlets
    
    @IBOutlet weak var recommendedCardView: UIView!
    @IBOutlet weak var recommendedTableView: UITableView!
    
    @IBOutlet weak var allExercisesCardView: UIView!
    @IBOutlet weak var allExercisesTableView: UITableView!
    
    // MARK: - Data Sources
    
    private var recommendedExercises: [Exercise] = []
    private var allExercises: [Exercise] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCardViews()
        setupTableViews()
        loadData()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        title = "Exercises"
    }
    
    private func setupCardViews() {
        let cardViews = [recommendedCardView, allExercisesCardView]
        let tableViews: [UITableView] = [recommendedTableView, allExercisesTableView]
        for card in cardViews {
            // Use the cardStyling helper functions from your project
            card?.layer.cornerRadius = 17
            CardStyling.setShadows(view: card!)
        }
        for tables in tableViews {
            tables.layer.cornerRadius = 17
        }
    }
    
    private func setupTableViews() {
        recommendedTableView.delegate = self
        recommendedTableView.dataSource = self
        
        allExercisesTableView.delegate = self
        allExercisesTableView.dataSource = self
        
        // Register XIB for cell
        let nib = UINib(nibName: "ExerciseTableViewCell", bundle: nil)
        recommendedTableView.register(nib, forCellReuseIdentifier: "ExerciseTableViewCell")
        allExercisesTableView.register(nib, forCellReuseIdentifier: "ExerciseTableViewCell")
        
        // Register XIB for instruction controller (optional, but clean)
        recommendedTableView.tableFooterView = UIView()
        allExercisesTableView.tableFooterView = UIView()
    }

    
    private func loadData() {
        // Create a temporary user with some conditions for testing
        // In real app, this would come from your saved user data
        currentUser = User(
            firstName: "John",
            lastName: "Doe",
            gender: "Male",
            dob: makeDate(year: 1995, month: 5, day: 15),
            eyeHealthData: UserEyeHealthData(
                condition: [.blurredVision, .eyeFatigue]
            )
        )
        
        guard let user = currentUser else { return }
        
        // Fetch recommended and all exercises
        recommendedExercises = ExerciseFetcher.getRecommendedExercises(for: user)
        allExercises = ExerciseFetcher.getAllExercises()
        
        recommendedTableView.reloadData()
        allExercisesTableView.reloadData()
    }

    
}
// MARK: - UITableViewDataSource & UITableViewDelegate

extension ExerciseListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recommendedTableView {
            return recommendedExercises.count
        } else {
            return allExercises.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as! ExerciseTableViewCell
        
        // Get the exercise for this row
        let exercise: Exercise
        if tableView == recommendedTableView {
            exercise = recommendedExercises[indexPath.row]
        } else {
            exercise = allExercises[indexPath.row]
        }
        
        // Configure the cell with exercise data and play button handler
        cell.configure(with: exercise) { [weak self] selectedExercise in
            self?.playButtonTapped(for: selectedExercise)
        }
        
        return cell
    }
    
    // MARK: - Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Height for each cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let exercise: Exercise
        if tableView == recommendedTableView {
            exercise = recommendedExercises[indexPath.row]
        } else {
            exercise = allExercises[indexPath.row]
        }
        
        // Show instruction modal
        showInstructionModal(for: exercise)
    }

    
    // MARK: - User Actions
    private func playButtonTapped(for exercise: Exercise) {
        
        // Get calibration VC from storyboard
        let storyboard = UIStoryboard(name: "exerciseList", bundle: nil)
        let calibrationVC = storyboard.instantiateViewController(withIdentifier: "CalibrationViewController") as! CalibrationViewController
        calibrationVC.exercise = exercise
        
        navigationController?.pushViewController(calibrationVC, animated: true)
    }

    private func showInstructionModal(for exercise: Exercise) {
        // Get instruction VC from storyboard
        let storyboard = UIStoryboard(name: "exerciseList", bundle: nil)
        let instructionVC = storyboard.instantiateViewController(withIdentifier: "InstructionViewController") as! InstructionViewController
        instructionVC.exercise = exercise
        
        // Embed in navigation controller for back button
        let navController = UINavigationController(rootViewController: instructionVC)
        navController.modalPresentationStyle = .pageSheet
        
        present(navController, animated: true)
    }
}
