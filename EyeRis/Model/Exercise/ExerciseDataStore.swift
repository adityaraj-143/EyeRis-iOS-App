//
//  ExerciseMockDataStore.swift
//  EyeRis
//
//  Created by SDC-USER on 12/12/25.
//

import Foundation
//MARK: EXERCISE HISTORY
// Dummy data for Exercise History

let mockPerformedExerciseStats: [PerformedExerciseStat] = [

    // MARK: - Current Week
    PerformedExerciseStat(
        id: 1,
        name: "Eye Focus Drill",
        performedOn: Date(timeIntervalSinceNow: -1 * 24 * 60 * 60),
        accuracy: 92,
        speed: 85
    ),
    PerformedExerciseStat(
        id: 2,
        name: "Blink Control",
        performedOn: Date(timeIntervalSinceNow: -2 * 24 * 60 * 60),
        accuracy: 88,
        speed: 80
    ),
    PerformedExerciseStat(
        id: 3,
        name: "Peripheral Vision",
        performedOn: Date(timeIntervalSinceNow: -3 * 24 * 60 * 60),
        accuracy: 90,
        speed: 78
    ),
    PerformedExerciseStat(
        id: 4,
        name: "Near-Far Focus",
        performedOn: Date(timeIntervalSinceNow: -4 * 24 * 60 * 60),
        accuracy: 86,
        speed: 82
    ),

    // MARK: - 1 Week Ago
    PerformedExerciseStat(
        id: 5,
        name: "Eye Focus Drill",
        performedOn: Date(timeIntervalSinceNow: -8 * 24 * 60 * 60),
        accuracy: 85,
        speed: 76
    ),
    PerformedExerciseStat(
        id: 6,
        name: "Blink Control",
        performedOn: Date(timeIntervalSinceNow: -9 * 24 * 60 * 60),
        accuracy: 82,
        speed: 74
    ),
    PerformedExerciseStat(
        id: 7,
        name: "Color Recognition",
        performedOn: Date(timeIntervalSinceNow: -10 * 24 * 60 * 60),
        accuracy: 88,
        speed: 79
    ),

    // MARK: - 2 Weeks Ago
    PerformedExerciseStat(
        id: 8,
        name: "Peripheral Vision",
        performedOn: Date(timeIntervalSinceNow: -15 * 24 * 60 * 60),
        accuracy: 80,
        speed: 72
    ),
    PerformedExerciseStat(
        id: 9,
        name: "Near-Far Focus",
        performedOn: Date(timeIntervalSinceNow: -16 * 24 * 60 * 60),
        accuracy: 83,
        speed: 75
    ),
    PerformedExerciseStat(
        id: 10,
        name: "Eye Tracking",
        performedOn: Date(timeIntervalSinceNow: -17 * 24 * 60 * 60),
        accuracy: 79,
        speed: 70
    ),
    PerformedExerciseStat(
        id: 11,
        name: "Blink Control",
        performedOn: Date(timeIntervalSinceNow: -18 * 24 * 60 * 60),
        accuracy: 81,
        speed: 73
    ),

    // MARK: - 3 Weeks Ago
    PerformedExerciseStat(
        id: 12,
        name: "Eye Focus Drill",
        performedOn: Date(timeIntervalSinceNow: -22 * 24 * 60 * 60),
        accuracy: 78,
        speed: 68
    ),
    PerformedExerciseStat(
        id: 13,
        name: "Peripheral Vision",
        performedOn: Date(timeIntervalSinceNow: -23 * 24 * 60 * 60),
        accuracy: 76,
        speed: 66
    ),
    PerformedExerciseStat(
        id: 14,
        name: "Color Recognition",
        performedOn: Date(timeIntervalSinceNow: -24 * 24 * 60 * 60),
        accuracy: 79,
        speed: 69
    )
]
