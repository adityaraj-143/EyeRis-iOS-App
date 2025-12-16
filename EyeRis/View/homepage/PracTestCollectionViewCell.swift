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
    
    
    var onFirstCardTap: (() -> Void)?
    var onSecondCardTap: (() -> Void)?
    var onThirdCardTap: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.applyCornerRadius()
        clipsToBounds = true
        contentView.clipsToBounds = true

        [cellCardView, cellCardView1, cellCardView2].forEach {
            $0?.applyCornerRadius()
            $0?.applyShadow()
            $0?.isUserInteractionEnabled = true
        }


        cellCardView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(firstTapped))
        )

        cellCardView1.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(secondTapped))
        )

        cellCardView2.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(thirdTapped))
        )
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {

        let attrs = super.preferredLayoutAttributesFitting(layoutAttributes)

        // Force the cell to use the width decided by the layout
        attrs.size.width = layoutAttributes.size.width

        return attrs
    }


    @objc private func firstTapped() {
        onFirstCardTap?()
    }
    @IBAction func firstChevronTapped(_ sender: Any) {
        onFirstCardTap?()

    }
    
    @objc private func secondTapped() {
        onSecondCardTap?()
    }
    @IBAction func secondChevronTapped(_ sender: Any) {
        onSecondCardTap?()

    }
    
    @objc private func thirdTapped() {
        onThirdCardTap?()
    }
    @IBAction func thirdChevronTapped(_ sender: Any) {
        onThirdCardTap?()

    }
}
