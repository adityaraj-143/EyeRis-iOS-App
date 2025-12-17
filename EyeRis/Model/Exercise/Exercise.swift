//
//  Exercise.swift
//  EyeRis
//
//  Created by SDC-USER on 12/12/25.
//

import Foundation

struct Exercise{
    var id: Int
    var name: String
    var duration: Int
    var instructions: ExerciseInstruction
    var targetedConditions : [Conditions]
    // to see if the exercise is recommended on the basis of userEyeConditions
    func isRecommended(for user: User) -> Bool {
        // Convert both arrays to Sets for fast intersection
        let userConditions = Set(user.eyeHealthData.condition)
        let exerciseConditions = Set(targetedConditions)

        // If intersection is not empty → recommended
        return !userConditions.intersection(exerciseConditions).isEmpty
    }
}

struct ExerciseInstruction{
    var title: String
    var description: [String]
    var video: String
}

struct PerformedExerciseStat {
    var id: Int
    var name: String
    var performedOn: Date
    var accuracy: Int
    var speed: Int
}

struct PerformedExerciseStatResponse {

    private let stats: [PerformedExerciseStat]
    private let calendar = Calendar.current

    // MARK: - Init

    init(stats: [PerformedExerciseStat] = mockPerformedExerciseStats) {
        self.stats = stats
    }

    // MARK: - Four Week Dates (28 days)

    func getFourWeekDateRange() -> [Date] {
        guard let latestDate = stats.map({ $0.performedOn }).max() else {
            return []
        }

        var dates: [Date] = []

        for dayOffset in 0..<28 {
            if let date = calendar.date(byAdding: .day, value: -dayOffset, to: latestDate) {
                dates.append(calendar.startOfDay(for: date))
            }
        }

        return dates.reversed()
    }

    // MARK: - Performed Dates

    func getPerformedExerciseDates() -> Set<Date> {
        let dates = stats.map {
            calendar.startOfDay(for: $0.performedOn)
        }
        return Set(dates)
    }

    // MARK: - Grouped Exercises

    func groupExercisesByDate() -> [Date: [PerformedExerciseStat]] {
        Dictionary(grouping: stats) {
            calendar.startOfDay(for: $0.performedOn)
        }
    }

    // MARK: - Exercises for Day

    func exercises(for date: Date) -> [PerformedExerciseStat] {
        let grouped = groupExercisesByDate()
        return grouped[calendar.startOfDay(for: date)] ?? []
    }
}
