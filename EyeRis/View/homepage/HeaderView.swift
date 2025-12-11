//
//  HeaderView.swift
//  EyeRis
//
//  Created by SDC-USER on 03/12/25.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(str: String) {
        headerLabel.text = str
        headerLabel.font = .boldSystemFont(ofSize: 22)
    }
    
}
