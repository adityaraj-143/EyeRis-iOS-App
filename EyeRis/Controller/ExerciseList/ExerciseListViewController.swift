//
//  exListViewController.swift
//  Eyeris Testing
//
//  Created by SDC-USER on 03/12/25.
//

import UIKit

class ExerciseListViewController: UIViewController {
    
    private var currentUser: User?
    private var recommendedExercises: [Exercise] = []
    private var allExercises: [Exercise] = []

    @IBOutlet weak var recommendedCardView: UIView!
    @IBOutlet weak var recommendedTableView: UITableView!
    @IBOutlet weak var allExercisesCardView: UIView!
    @IBOutlet weak var allExercisesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCardViews()
        setupTableViews()
        loadData()
    }
    
    // MARK: - Setup
    private func setupCardViews() {
        [recommendedCardView,allExercisesCardView].forEach {
            $0?.applyCornerRadius()
            $0?.applyShadow()
        }
    }
    
    private func setupTableViews() {
        recommendedTableView.delegate = self
        recommendedTableView.dataSource = self
        
        allExercisesTableView.delegate = self
        allExercisesTableView.dataSource = self
        
        [recommendedTableView,allExercisesTableView].forEach {
            $0?.applyCornerRadiusToTable()
        }
        
        // Register XIB for cell
        let nib = UINib(nibName: "ExerciseTableViewCell", bundle: nil)
        recommendedTableView.register(nib, forCellReuseIdentifier: "ExerciseTableViewCell")
        allExercisesTableView.register(nib, forCellReuseIdentifier: "ExerciseTableViewCell")
    }

    private func loadData() {
        //temporary user with some conditions for testing
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
        
        //fetch recommended & all exercises
        recommendedExercises = ExerciseFetcher.getRecommendedExercises(for: user)
        allExercises = ExerciseFetcher.getAllExercises()
        
        recommendedTableView.reloadData()
        allExercisesTableView.reloadData()
    }
}

// MARK: - Extensions
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
    
    // MARK: Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let exercise: Exercise
        if tableView == recommendedTableView {
            exercise = recommendedExercises[indexPath.row]
        } else {
            exercise = allExercises[indexPath.row]
        }
        
        showInstructionModal(for: exercise)
    }

    // MARK: Actions
    private func playButtonTapped(for exercise: Exercise) {
        
        let storyboard = UIStoryboard(name: "CalibrationScreen", bundle: nil)
        let calibrationVC = storyboard.instantiateViewController(withIdentifier: "CalibrationViewController") as! CalibrationViewController
        calibrationVC.exercise = exercise
        
        navigationController?.pushViewController(calibrationVC, animated: true)
    }

    private func showInstructionModal(for exercise: Exercise) {

        let storyboard = UIStoryboard(name: "exerciseList", bundle: nil)
        let instructionVC = storyboard.instantiateViewController(withIdentifier: "InstructionViewController") as! InstructionViewController
        instructionVC.exercise = exercise
        
        //to embed in navigtion controller
        let navController = UINavigationController(rootViewController: instructionVC)
        navController.modalPresentationStyle = .pageSheet
        
        present(navController, animated: true)
    }
}
