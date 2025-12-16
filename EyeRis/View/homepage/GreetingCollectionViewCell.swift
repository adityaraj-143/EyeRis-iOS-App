//
//  GreetingCollectionViewCell.swift
//  EyeRis
//
//  Created by SDC-USER on 10/12/25.
//

import UIKit

class GreetingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var greetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        greetLabel.font = .boldSystemFont(ofSize: 28)

    }
    
}
