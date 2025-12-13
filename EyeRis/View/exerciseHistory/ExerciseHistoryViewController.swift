import UIKit

class ExerciseHistoryViewController: UIViewController {

    @IBOutlet weak var weekCollectionView: UICollectionView!

    // MARK: - Constants

    // Number of weeks shown (each week = 7 days)
    private let weeksCount: Int = 4
    private let weekDays = ["M", "T", "W", "T", "F", "S", "S"]

    // Total cells = weeks × days
    private let totalItems = 28

    // MARK: - Data

    private let allStats: [PerformedExerciseStat] = mockPerformedExerciseStats

    /// Ordered list of 28 dates (oldest → latest)
    private var fourWeekDates: [Date] = []

    /// Dates on which at least one exercise was performed
    private var performedDates: Set<Date> = []

    /// Aggregated exercises per date
    private var exercisesByDate: [Date: [PerformedExerciseStat]] = [:]

    /// Currently selected day (UI state, single selection)
    private var selectedIndexPath: IndexPath?

    private let calendar = Calendar.current

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        weekCollectionView.register(
            UINib(nibName: "WeekdayCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "dayCell"
        )

        // Prepare data using model helpers
        fourWeekDates = PerformedExerciseStat.getFourWeekDateRange(from: allStats)
        performedDates = Set(PerformedExerciseStat.getPerformedExerciseDates(from: allStats))
        exercisesByDate = PerformedExerciseStat.groupExercisesByDate(stats: allStats)

        weekCollectionView.dataSource = self
        weekCollectionView.delegate = self

        // Horizontal-only scrolling configuration
        weekCollectionView.showsHorizontalScrollIndicator = false
        weekCollectionView.showsVerticalScrollIndicator = false
        weekCollectionView.alwaysBounceVertical = false
        weekCollectionView.alwaysBounceHorizontal = true
        weekCollectionView.isDirectionalLockEnabled = true
        weekCollectionView.decelerationRate = .fast
        weekCollectionView.isScrollEnabled = true

        weekCollectionView.collectionViewLayout = makeWeekLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Start on the latest week
        let lastWeekFirstItem = (weeksCount - 1) * weekDays.count
        let indexPath = IndexPath(item: lastWeekFirstItem, section: 0)

        DispatchQueue.main.async {
            self.weekCollectionView.scrollToItem(
                at: indexPath,
                at: .left,
                animated: false
            )
        }
    }

    // MARK: - Layout

    private func makeWeekLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 7.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 8, bottom: 8, trailing: 8
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(72)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: Array(repeating: item, count: 7)
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 20, bottom: 0, trailing: 20
        )
        section.interGroupSpacing = 8

        return UICollectionViewCompositionalLayout(section: section)
    }

    // MARK: - Helpers

    /// Maps an indexPath to its actual calendar date
    private func dateForIndexPath(_ indexPath: IndexPath) -> Date? {
        guard indexPath.item < fourWeekDates.count else { return nil }
        return fourWeekDates[indexPath.item]
    }
}

// MARK: - UICollectionView DataSource & Delegate

extension ExerciseHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return totalItems
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "dayCell",
            for: indexPath
        ) as? WeekdayCollectionViewCell else {
            return UICollectionViewCell()
        }

        let dayIndex = indexPath.item % weekDays.count
        let letter = weekDays[dayIndex]

        let date = dateForIndexPath(indexPath)
        let hasExercise = date.map { performedDates.contains($0) } ?? false
        let isSelected = indexPath == selectedIndexPath

        cell.configureCell(
            letter: letter,
            hasExercise: hasExercise,
            isSelected: isSelected
        )

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        let previousSelection = selectedIndexPath
        selectedIndexPath = indexPath

        // Reload only affected cells
        var indexPathsToReload: [IndexPath] = [indexPath]
        if let previous = previousSelection {
            indexPathsToReload.append(previous)
        }

        collectionView.reloadItems(at: indexPathsToReload)

        // Fetch detailed data for the selected date
        if let date = dateForIndexPath(indexPath) {
            let exercises = exercisesByDate[date] ?? []
            print("Selected date:", date)
            print("Exercises:", exercises)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let maxX = CGFloat(weeksCount - 1) * pageWidth

        if scrollView.contentOffset.x < 0 {
            scrollView.contentOffset.x = 0
        }

        if scrollView.contentOffset.x > maxX {
            scrollView.contentOffset.x = maxX
        }
    }
}
