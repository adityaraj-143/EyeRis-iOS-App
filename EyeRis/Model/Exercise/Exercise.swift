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

    // MARK: - Date Helpers

    static func getFourWeekDateRange(from stats: [PerformedExerciseStat]) -> [Date] {
        guard let latestDate = stats.map({ $0.performedOn }).max() else {
            return []
        }

        let calendar = Calendar.current
        var dates: [Date] = []

        for dayOffset in 0..<28 {
            if let date = calendar.date(byAdding: .day, value: -dayOffset, to: latestDate) {
                dates.append(calendar.startOfDay(for: date))
            }
        }

        return dates.reversed()
    }

    static func getPerformedExerciseDates(from stats: [PerformedExerciseStat]) -> [Date] {
        let calendar = Calendar.current

        let dates = stats.map {
            calendar.startOfDay(for: $0.performedOn)
        }

        return Array(Set(dates)).sorted()
    }

    static func groupExercisesByDate(
        stats: [PerformedExerciseStat]
    ) -> [Date: [PerformedExerciseStat]] {

        let calendar = Calendar.current

        return Dictionary(grouping: stats) {
            calendar.startOfDay(for: $0.performedOn)
        }
    }
}
