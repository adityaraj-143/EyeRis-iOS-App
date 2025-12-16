//
//  BlinkRateHistoryViewController.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit

struct BlinkWeek {
    let startDate: Date
    let days: [BlinkRateTestResult?] // count = 7
}

func makeLast4Weeks(from data: [BlinkRateTestResult]) -> [BlinkWeek] {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())

    let byDate = Dictionary(
        uniqueKeysWithValues: data.map {
            (calendar.startOfDay(for: $0.performedOn), $0)
        }
    )

    var weeks: [BlinkWeek] = []

    for offset in (0..<4).reversed() {
        guard let weekStart = calendar.date(
            byAdding: .weekOfYear,
            value: -offset,
            to: today
        )?.startOfWeek else { continue }

        let days = (0..<7).map { day -> BlinkRateTestResult? in
            let date = calendar.date(byAdding: .day, value: day, to: weekStart)!
            return byDate[date]
        }

        weeks.append(BlinkWeek(startDate: weekStart, days: days))
    }

    return weeks
}

extension Date {
    var startOfWeek: Date {
        Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.yearForWeekOfYear, .weekOfYear],
                from: self
            )
        )!
    }
}

class BlinkRateHistoryViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var todayDataComment: UILabel!
    @IBOutlet weak var todayDataBPM: UILabel!
    @IBOutlet weak var todayDataView: UIView!
    
    private var weeks: [BlinkWeek] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayDataView.applyCornerRadius()
        todayDataComment.text = "That’s good! Anything above 20 is nice"

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
        let todayResult = BlinkRateMockData.mockBlinkRateResults.first {
            Calendar.current.isDateInToday($0.performedOn)
        }

        let value = todayResult?.bpm ?? 0

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
        weeks = makeLast4Weeks(from: BlinkRateMockData.mockBlinkRateResults)
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
