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
        setCornerRadius([resultView, commentView, mainView, resultView1])
        
        setShadows([resultView, resultView1])


    }
        
    var onTapNavigation: (() -> Void)?
    
    @IBAction func buttonToNavAction(_ sender: Any) {
        onTapNavigation?()
    }
}
