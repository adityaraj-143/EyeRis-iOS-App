//
//  HomeNavigation.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit

// MARK: - Navigation
extension ViewController {

    func goToPlaceholderPage() {
        let storyboard = UIStoryboard(
            name: "TestInstructions", // temporary
            bundle: nil
        )

        let vc = storyboard.instantiateViewController(
            withIdentifier: "TestInstructionViewController"
        ) as! TestInstructionViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    func goToTestInstructions() {
        let storyboard = UIStoryboard(
            name: "TestInstructions",
            bundle: nil
        )

        let vc = storyboard.instantiateViewController(
            withIdentifier: "TestInstructionViewController"
        ) as! TestInstructionViewController

        navigationController?.pushViewController(vc, animated: true)
    }

    func goToTestResult() {
        let storyboard = UIStoryboard(
            name: "TestResultFlow",
            bundle: nil
        )

        let vc = storyboard.instantiateViewController(
            withIdentifier: "TestResultViewController"
        ) as! TestResultViewController

        navigationController?.pushViewController(vc, animated: true)
    }
}
