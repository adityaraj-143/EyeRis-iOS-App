//
//  HomeNavigation.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit

// MARK: - Navigation
extension ViewController {
    
    func navigate(
        to storyboardName: String,
        with identifier: String,
        source: TestFlowSource? = nil
    ) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(
            withIdentifier: identifier
        )

        if let testVC = vc as? TestInstructionViewController {
            testVC.source = source
        }

        navigationController?.pushViewController(vc, animated: true)
    }

    
    func presentProfilePage() {
        let storyboard = UIStoryboard(name: "ProfilePage", bundle: nil)
        
        let profileVC = storyboard.instantiateViewController(
            withIdentifier: "profilePageViewController"
        )

        let navController = UINavigationController(rootViewController: profileVC)
        navController.modalPresentationStyle = .pageSheet   // or .fullScreen

        present(navController, animated: true)
    }

}
