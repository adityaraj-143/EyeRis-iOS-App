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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 17
        commentView.layer.cornerRadius = 17
//        resultView.layer.cornerRadius = 17
        
        resultView.layer.shadowPath = UIBezierPath(roundedRect: resultView.bounds, cornerRadius: 17).cgPath
    }

}
