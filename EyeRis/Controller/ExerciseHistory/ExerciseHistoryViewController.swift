import UIKit

class ExerciseHistoryViewController: UIViewController {
    
    @IBOutlet weak var weekCollectionView: UICollectionView!
    
    @IBOutlet weak var avgAccuracy: UILabel!
    @IBOutlet weak var avgSpeed: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    @IBOutlet weak var exerciseTableView: UITableView!
    
    private var selectedIndexPath: IndexPath?
    private var selectedDate: Date?
    private var selectedDayExercises: [PerformedExerciseStat] = []
    
    
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var commentView: UIView!
    
    // MARK: - Constants
    private let weeksCount = 4
    private let weekDays = ["M", "T", "W", "T", "F", "S", "S"]
    private let totalItems = 28
    
    // MARK: - Data
    private let allStats: [PerformedExerciseStat] = mockPerformedExerciseStats
    private var fourWeekDates: [Date] = []
    private var performedDates: Set<Date> = []
    private var exercisesByDate: [Date: [PerformedExerciseStat]] = [:]
    
    // Date formatter to formaat the date in the format to be displayed in the navigation bar
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE, d MMM"
        return df
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekCollectionView.register(
            UINib(nibName: "WeekdayCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "dayCell"
        )
        
        fourWeekDates = PerformedExerciseStat.getFourWeekDateRange(from: allStats)
        performedDates = Set(PerformedExerciseStat.getPerformedExerciseDates(from: allStats))
        exercisesByDate = PerformedExerciseStat.groupExercisesByDate(stats: allStats)
        
        weekCollectionView.dataSource = self
        weekCollectionView.delegate = self
        weekCollectionView.collectionViewLayout = makeWeekLayout()
        
        exerciseTableView.dataSource = self
        exerciseTableView.isScrollEnabled = false
        
        exerciseTableView.rowHeight = UITableView.automaticDimension
        exerciseTableView.estimatedRowHeight = 80
        
        // Adding corner radius and shadow to the cards
        [summaryView, commentView].forEach {
            $0?.applyCornerRadius()
        }
        
        exerciseTableView.applyCornerRadiusToTable()
        
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 4))
        spacer.backgroundColor = .clear
        exerciseTableView.tableHeaderView = spacer

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let lastIndex = fourWeekDates.count - 1
        let indexPath = IndexPath(item: lastIndex, section: 0)
        
        DispatchQueue.main.async {
            self.selectedIndexPath = indexPath
            self.weekCollectionView.scrollToItem(
                at: indexPath,
                at: .left,
                animated: false
            )
            self.handleDateSelection(self.fourWeekDates[lastIndex])
            self.weekCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    // MARK: - Layout
    private func makeWeekLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 7.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(72)
            ),
            subitems: Array(repeating: item, count: 7)
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - Helpers
    private func dateForIndexPath(_ indexPath: IndexPath) -> Date? {
        guard indexPath.item < fourWeekDates.count else { return nil }
        return fourWeekDates[indexPath.item]
    }
    
    private func handleDateSelection(_ date: Date) {
        selectedDate = date
        // Update title
        navigationItem.title = dateFormatter.string(from: date)
        selectedDayExercises = exercisesByDate[date] ?? []
        updateSummary(for: selectedDayExercises)
        exerciseTableView.reloadData()
    }
    
    private func updateSummary(for stats: [PerformedExerciseStat]) {
        guard !stats.isEmpty else {
            avgAccuracy.text = "--"
            avgSpeed.text = "--"
            comment.text = "No exercises performed on this day."
            avgSpeed.textColor = .black
            avgAccuracy.textColor = .black
            return
        }
        
        let avgAcc = stats.map { $0.accuracy }.reduce(0, +) / stats.count
        let avgSpd = stats.map { $0.speed }.reduce(0, +) / stats.count
        
        avgAccuracy.text = "\(avgAcc)%"
        avgSpeed.text = "\(avgSpd)%"
        if avgAcc >= 90 || avgSpd >= 90 {
            comment.text = "Your eye coordination looks good. Regular exercise will maintain your eye health."
        } else if avgAcc >= 80 || avgSpd >= 80 {
            comment.text = "Your eye coordination is decent, but there’s room for improvement. Try to stay consistent with your exercises."
        } else {
            comment.text = "Your eye coordination needs improvement. Regular and focused practice can help strengthen your eye health."
        }

        
        if avgAcc >= 85 {
            avgAccuracy.textColor = .green
        }else if avgAcc >= 75 {
            avgAccuracy.textColor = .orange
        }else{
            avgAccuracy.textColor = .red
        }
        
        if avgSpd >= 85 {
            avgSpeed.textColor = .green
        } else if avgSpd >= 75{
            avgSpeed.textColor = .orange
        } else{
            avgSpeed.textColor = .red
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension ExerciseHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        totalItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "dayCell",
            for: indexPath
        ) as? WeekdayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let letter = weekDays[indexPath.item % weekDays.count]
        let date = dateForIndexPath(indexPath)
        let hasExercise = date.map { performedDates.contains($0) } ?? false
        let isSelected = indexPath == selectedIndexPath
        
        cell.configureCell(letter: letter,
                           hasExercise: hasExercise,
                           isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let previous = selectedIndexPath
        selectedIndexPath = indexPath
        
        var reload = [indexPath]
        if let prev = previous { reload.append(prev) }
        collectionView.reloadItems(at: reload)
        
        if let date = dateForIndexPath(indexPath) {
            handleDateSelection(date)
        }
    }
}

// MARK: - UITableViewDataSource
extension ExerciseHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        selectedDayExercises.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ExerciseCell",
            for: indexPath
        ) as? ExerciseStatTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: selectedDayExercises[indexPath.row])
        return cell
    }
    
}

