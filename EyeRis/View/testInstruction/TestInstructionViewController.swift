//
//  TestInstructionViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

class TestInstructionViewController: UIViewController, UICollectionViewDelegate {


    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    let test = mockTest

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()

        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.collectionViewLayout = generateLayout()

        instructionLabel.text = test.instruction.description.first
    }

    private func registerCell() {
        CollectionView.register(
            UINib(nibName: "TestInstructionsCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "TestInstructionsCollectionViewCell"
        )
    }
}

// MARK: - Collection View Layout
extension TestInstructionViewController {

    func generateLayout() -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout { section, env in

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),   // slightly smaller to show next page peeking
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            group.interItemSpacing = .fixed(10)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 10
            
            return section
        }

        return layout
    }
}

// MARK: - DataSource
extension TestInstructionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.instruction.description.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TestInstructionsCollectionViewCell",
            for: indexPath
        ) as! TestInstructionsCollectionViewCell

        let img = test.instruction.images[indexPath.item]
        cell.configureCell(image: img)
        instructionLabel.text = "\(test.instruction.description[indexPath.item])"

        return cell
    }
}

// MARK: - Scroll Handling (update label)
extension TestInstructionViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(CollectionView.contentOffset.x / CollectionView.frame.size.width)
        instructionLabel.text = test.instruction.description[page]
    }
}
