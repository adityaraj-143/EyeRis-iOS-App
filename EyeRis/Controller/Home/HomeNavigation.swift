//
//  HomeNavigation.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit

// MARK: - Navigation
extension ViewController {
    
    func navigate(to storyboardName: String, with storyboardId: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
