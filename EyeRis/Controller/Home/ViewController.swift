import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var profileIconView: UIView!

    let headerKind = "header-kind"

    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionView.setCollectionViewLayout(generateLayout(), animated: false)
        CollectionView.dataSource = self

        registerCells()
    }

    // MARK: - Register Cells
    private func registerCells() {
        CollectionView.register(UINib(nibName: "GreetingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "greet_cell")
        CollectionView.register(UINib(nibName: "DailyTipCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tip_cell")
        CollectionView.register(UINib(nibName: "TodayExerciseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "todayExercise_cell")
        CollectionView.register(UINib(nibName: "PracTestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pracTest_cell")
        CollectionView.register(UINib(nibName: "BlinkRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "blinkRate_cell")
        CollectionView.register(UINib(nibName: "LastExerciseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "lastExercise_cell")
        CollectionView.register(UINib(nibName: "LastTestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "lastTest_cell")

        CollectionView.register(
            UINib(nibName: "HeaderView", bundle: nil),
            forSupplementaryViewOfKind: headerKind,
            withReuseIdentifier: "header_cell"
        )
    }
}



// MARK: - DataSource
extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int { 7 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 1 }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {

        case 0:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "greet_cell", for: indexPath)

        case 1:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "tip_cell", for: indexPath)

        case 2:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "todayExercise_cell", for: indexPath)

        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "pracTest_cell",
                for: indexPath
            ) as! PracTestCollectionViewCell

            // First card → placeholder
            cell.onFirstCardTap = { [weak self] in
                self?.goToPlaceholderPage()
            }

            // Second card → TestInstructions
            cell.onSecondCardTap = { [weak self] in
                self?.goToTestInstructions()
            }

            // Third card → TestInstructions
            cell.onThirdCardTap = { [weak self] in
                self?.goToTestInstructions()
            }

            return cell


        case 4:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "blinkRate_cell",
                for: indexPath
            ) as! BlinkRateCollectionViewCell
            cell.blinkRateSliderView.value = 9
            cell.blinkRateSliderView.maxValue = 22
            return cell

        case 5:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "lastExercise_cell", for: indexPath)

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
