//
//  TestInstructionViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 11/12/25.
//

import UIKit

enum TestFlowSource {
    case acuityTest
    case blinkRateTest
}


class TestInstructionViewController: UIViewController, UICollectionViewDelegate {
    
    
    @IBOutlet weak var pageControlOutlet: UIPageControl!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    var source: TestFlowSource?

    let test = mockTest
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        
        switch source {
        case .acuityTest:
            print("Came from Second Card")

        case .blinkRateTest:
            print("Came from Third Card")
            
        case .none:
            break
        }
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.collectionViewLayout = generateLayout()
        
        instructionLabel.text = test.instruction.description.first
        pageControlOutlet.numberOfPages = test.instruction.description.count
        pageControlOutlet.currentPage = 0
        
        pageControlOutlet.addTarget(
            self,
            action: #selector(pageControlChanged(_:)),
            for: .valueChanged
        )
        
        
    }
    
    @IBAction func navToCalibrate(_ sender: Any) {
        navigate(
            to: "CalibrationScreen",
            with: "CalibrationViewController",
            source: source
        )
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
            
            section.visibleItemsInvalidationHandler = { [weak self] items, offset, env in
                guard let self else { return }
                
                let centerX = offset.x + env.container.contentSize.width / 2
                
                if let centeredItem = items.min(by: {
                    abs($0.frame.midX - centerX) < abs($1.frame.midX - centerX)
                }) {
                    
                    let index = centeredItem.indexPath.item
                    
                    // Label update
                    self.instructionLabel.text = self.test.instruction.description[index]
                    
                    // PageControl update (animated)
                    if self.pageControlOutlet.currentPage != index {
                        UIView.animate(withDuration: 0.25) {
                            self.pageControlOutlet.currentPage = index
                        }
                    }
                }
            }
            
            
            
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
        
        
        return cell
    }
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let index = sender.currentPage
        let indexPath = IndexPath(item: index, section: 0)
        
        CollectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
    
}

extension TestInstructionViewController {
    func navigate(
        to storyboardName: String,
        with identifier: String,
        source: TestFlowSource? = nil
    ) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)

        if let instructionVC = vc as? TestInstructionViewController {
            instructionVC.source = source
        }

        if let calibrationVC = vc as? CalibrationViewController {
            calibrationVC.source = source
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}
