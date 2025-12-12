//
//  LastTestCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class LastTestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var navigatorButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var resultView1: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        [resultView, commentView, mainView, resultView1].forEach {
            $0?.applyCornerRadius()
        }
        
        [resultView, resultView1].forEach {
            $0?.applyShadow()
        }
    }
        
    var onTapNavigation: (() -> Void)?
    
    @IBAction func buttonToNavAction(_ sender: Any) {
        onTapNavigation?()
    }
}
