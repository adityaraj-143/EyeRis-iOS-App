//
//  ViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 24/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let layout = generateLayout()
        CollectionView.setCollectionViewLayout(layout, animated: true)
        CollectionView.dataSource = self
        registerCell()
        
        
    }
    
    func registerCell () {
        CollectionView.register(UINib(nibName: "DailyTipCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tip_cell")
        
        CollectionView.register(UINib(nibName: "TodayExerciseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "todayExercise_cell")
        
        CollectionView.register(UINib(nibName: "PracTestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pracTest_cell")
        
        CollectionView.register(UINib(nibName: "BlinkRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "blinkRate_cell")
    }
    
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, env in
            
            // MARK: - SECTION 0  ("Tip of the day")
            if section == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(84)
                    )
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(84)
                )
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 12, trailing: 20)
                
                return section
            }
            
            // MARK: - SECTION 1  ("Today's Exercise Set")
            else if section == 1 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(71)
                    )
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(71)
                )
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
                
                return section
            }
            
            // MARK: - SECTION 2  ("PracTest" 3 small cards)
            else if section == 2 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(152)
                    )
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(354),
                    heightDimension: .absolute(152)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
                section.interGroupSpacing = 12
                
                return section
            }
            
            else if section == 3 {

                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(165)                    )
                )

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(165)
                )

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0, leading: 20, bottom: 20, trailing: 20
                )

                return section
            }
            
            return nil
        }
        
        return layout
    }

    
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tip_cell", for: indexPath) as! DailyTipCollectionViewCell
            
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayExercise_cell", for: indexPath) as! TodayExerciseCollectionViewCell
            
            return cell
        }
        else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pracTest_cell", for: indexPath) as! PracTestCollectionViewCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "blinkRate_cell", for: indexPath) as! BlinkRateCollectionViewCell
            
            cell.blinkRateSliderView.value = 9
            cell.blinkRateSliderView.maxValue = 22
            
            return cell
        }
    }
        
}
