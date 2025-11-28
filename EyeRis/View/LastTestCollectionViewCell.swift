//
//  LastTestCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class LastTestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var resultView1: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 17
        commentView.layer.cornerRadius = 17
        resultView.layer.cornerRadius = 17
        resultView1.layer.cornerRadius = 17
        
        resultView.layer.shadowColor = UIColor.black.cgColor
        resultView.layer.shadowOpacity = 0.1
        resultView.layer.shadowRadius = 10
        resultView.layer.shadowOffset = .zero
        resultView.layer.masksToBounds = false

        
        resultView1.layer.shadowColor = UIColor.black.cgColor
        resultView1.layer.shadowOpacity = 0.1
        resultView1.layer.shadowRadius = 10
        resultView1.layer.shadowOffset = .zero
        resultView1.layer.masksToBounds = false

    }

}
