import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    private let headerKind = "header-kind"
    
    @IBOutlet weak var profileIconView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        profileIconView.layer.cornerRadius = 50÷
        
        CollectionView.setCollectionViewLayout(generateLayout(), animated: false)
        CollectionView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        CollectionView.register(UINib(nibName: "GreetingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "greet_cell")
        CollectionView.register(UINib(nibName: "DailyTipCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tip_cell")
        CollectionView.register(UINib(nibName: "TodayExerciseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "todayExercise_cell")
        CollectionView.register(UINib(nibName: "PracTestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pracTest_cell")
        CollectionView.register(UINib(nibName: "BlinkRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "blinkRate_cell")
        CollectionView.register(UINib(nibName: "LastExerciseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "lastExercise_cell")
        CollectionView.register(UINib(nibName: "LastTestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "lastTest_cell")
        
        // Header
        CollectionView.register(
            UINib(nibName: "HeaderView", bundle: nil),
            forSupplementaryViewOfKind: headerKind,
            withReuseIdentifier: "header_cell"
        )
    }
}

extension ViewController {
    
    func generateLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { sectionIndex, env in
            
            let headerItem: NSCollectionLayoutBoundarySupplementaryItem = {
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                )
                
                return NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: size,
                    elementKind: self.headerKind,
                    alignment: .top
                )
            }()
            
            switch sectionIndex {
                
            case 0:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(348),
                        heightDimension: .absolute(50)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.contentInsets = NSDirectionalEdgeInsets(top: -30, leading: 30, bottom: 10, trailing: 30)
                
                return section
                
            case 1: // Tip of the day
                return Self.makeFullWidthSection(
                    height: 84,
                    top: 0,
                    bottom: 0
                )
                
            case 2: // Today's Exercise
                let section = Self.makeFullWidthSection(
                    height: 71,
                    top: 0,
                    bottom: 10
                )
                section.boundarySupplementaryItems = [headerItem]
                return section
                
            case 3: // Practice Test (horizontal)
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(152)
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(354),
                    heightDimension: .absolute(152)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 12
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                return section
                
            case 4: // Blink Rate
                let section = Self.makeFullWidthSection(
                    height: 165,
                    top: 0,
                    bottom: 10
                )
                section.boundarySupplementaryItems = [headerItem]
                return section
                
            case 5: // Last Exercise
                return Self.makeFullWidthSection(
                    height: 165,
                    top: 0,
                    bottom: 10
                )
                
            case 6: // Last Test
                return Self.makeFullWidthSection(
                    height: 216,
                    top: 0,
                    bottom: 10
                )
                
            default:
                return nil
            }
            
        }
    }
    
    static func makeFullWidthSection(height: CGFloat, top: CGFloat, bottom: CGFloat) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(height)
            )
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(354),
                heightDimension: .absolute(height)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: top, leading: 20, bottom: bottom, trailing: 20)
        return section
    }
}


extension ViewController: UICollectionViewDataSource {
    
    func goToTestResult() {
        let storyboard = UIStoryboard(
            name: "TestResultFlow",
            bundle: nil
        )
        
        let vc = storyboard.instantiateViewController(
            withIdentifier: "TestResultViewController"
        ) as! TestResultViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "greet_cell",
                for: indexPath
            )
            
        case 1:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "tip_cell",
                for: indexPath
            )
            
        case 2:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "todayExercise_cell",
                for: indexPath
            )
            
        case 3:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "pracTest_cell",
                for: indexPath
            )
            
        case 4:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "blinkRate_cell",
                for: indexPath
            ) as! BlinkRateCollectionViewCell
            cell.blinkRateSliderView.value = 9
            cell.blinkRateSliderView.maxValue = 22
            return cell
            
        case 5:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "lastExercise_cell",
                for: indexPath
            )
            
        case 6:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "lastTest_cell",
                for: indexPath
            ) as! LastTestCollectionViewCell
            
            cell.onTapNavigation = { [weak self] in
                self?.goToTestResult()
            }
            
            return cell
            
        default:
            fatalError("Unknown section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "header_cell",
            for: indexPath
        ) as! HeaderView
        
        if indexPath.section == 2 {
            header.configure(str: "Perform")
        }
        
        if indexPath.section == 4 {
            header.configure(str: "Summary")
        }
        
        return header
    }
}
