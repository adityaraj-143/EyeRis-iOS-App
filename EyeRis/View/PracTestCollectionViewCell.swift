//
//  PracTestCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class PracTestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cellCardView2: UIView!
    @IBOutlet weak var cellCardView1: UIView!
    @IBOutlet weak var cellCardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 17
        
        let temp = [cellCardView, cellCardView1, cellCardView2]
        
        for i in 0...temp.count-1{
            temp[i]?.layer.cornerRadius = 17
            temp[i]?.layer.shadowColor = UIColor.black.cgColor
            temp[i]?.layer.shadowOpacity = 0.1
            temp[i]?.layer.shadowRadius = 10
            temp[i]?.layer.shadowOffset = .zero
            temp[i]?.layer.masksToBounds = false
        }
    }
    
}
