//
//  BlinkRateHistoryViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit


class BlinkRateHistoryViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var todayDataComment: UILabel!
    @IBOutlet weak var todayDataBPM: UILabel!
    @IBOutlet weak var todayDataView: UIView!
    
    private var weeks: [BlinkWeek] = []
    private let response = BlinkRateTestResultResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayDataView.applyCornerRadius()

        prepareTodayData()
        prepareWeeklyData()


        // Do any additional setup after loading the view.
        CollectionView.register(UINib(nibName: "BlinkRateGraphCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "graph_cell")
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.decelerationRate = .fast

        CollectionView.collectionViewLayout = makeWeekLayout()
    }
    

    private func prepareTodayData() {
        let todayResult = response.todayResult()
        
        let value = todayResult?.bpm ?? 0
        if value <= 10 {
            todayDataComment.text = "That is concerning. You need to blink significantly more"
            todayDataBPM.textColor = .red
        }
        if value > 10 && value < 20 {
            todayDataComment.text = "Decent, but try to keep it above 20"
            todayDataBPM.textColor = .orange
        }
        if value >= 20 {
            todayDataComment.text = "Excellent! Anything above 20 is healthy"
            todayDataBPM.textColor = .green
        }
    

        let attributed = NSMutableAttributedString(
            string: "\(value)",
            attributes: [
                .font: todayDataBPM.font as Any
            ]
        )

        let bpmText = NSAttributedString(
            string: " bpm",
            attributes: [
                .font: UIFont.systemFont(ofSize: 12)
            ]
        )

        attributed.append(bpmText)
        todayDataBPM.attributedText = attributed

    }

    
    private func prepareWeeklyData() {
        weeks = response.makeLast4Weeks()
    }

    
    private func makeWeekLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(248)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 12
        section.contentInsets = .zero

        return UICollectionViewCompositionalLayout(section: section)
    }


}

extension BlinkRateHistoryViewController: UICollectionViewDataSource {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard !weeks.isEmpty else { return }

        let indexPath = IndexPath(item: weeks.count - 1, section: 0)
        CollectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: false
        )
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        weeks.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "graph_cell",
            for: indexPath
        ) as! BlinkRateGraphCollectionViewCell

        cell.configure(with: weeks[indexPath.item])
        return cell
    }
}
