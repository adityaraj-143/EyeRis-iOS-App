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
        performedOn: Date(timeIntervalSinceNow: -1 * 24 * 60 * 60),
        accuracy: 88,
        speed: 80
    ),
    PerformedExerciseStat(
        id: 3,
        name: "Peripheral Vision",
        performedOn: Date(timeIntervalSinceNow: -1 * 24 * 60 * 60),
        accuracy: 90,
        speed: 78
    ),
    PerformedExerciseStat(
        id: 4,
        name: "Near-Far Focus",
        performedOn: Date(timeIntervalSinceNow: -2 * 24 * 60 * 60),
        accuracy: 86,
        speed: 82
    ),
    PerformedExerciseStat(
        id: 5,
        name: "Eye Tracking",
        performedOn: Date(timeIntervalSinceNow: -2 * 24 * 60 * 60),
        accuracy: 84,
        speed: 79
    ),

    // MARK: - 3 Days Ago
    PerformedExerciseStat(
        id: 6,
        name: "Blink Control",
        performedOn: Date(timeIntervalSinceNow: -3 * 24 * 60 * 60),
        accuracy: 82,
        speed: 74
    ),
    PerformedExerciseStat(
        id: 7,
        name: "Color Recognition",
        performedOn: Date(timeIntervalSinceNow: -3 * 24 * 60 * 60),
        accuracy: 88,
        speed: 79
    ),

    // MARK: - 1 Week Ago
    PerformedExerciseStat(
        id: 8,
        name: "Peripheral Vision",
        performedOn: Date(timeIntervalSinceNow: -7 * 24 * 60 * 60),
        accuracy: 80,
        speed: 72
    ),
    PerformedExerciseStat(
        id: 9,
        name: "Near-Far Focus",
        performedOn: Date(timeIntervalSinceNow: -7 * 24 * 60 * 60),
        accuracy: 83,
        speed: 75
    ),
    PerformedExerciseStat(
        id: 10,
        name: "Eye Focus Drill",
        performedOn: Date(timeIntervalSinceNow: -7 * 24 * 60 * 60),
        accuracy: 81,
        speed: 73
    ),

    // MARK: - 2 Weeks Ago
    PerformedExerciseStat(
        id: 11,
        name: "Eye Tracking",
        performedOn: Date(timeIntervalSinceNow: -14 * 24 * 60 * 60),
        accuracy: 79,
        speed: 70
    ),
    PerformedExerciseStat(
        id: 12,
        name: "Blink Control",
        performedOn: Date(timeIntervalSinceNow: -14 * 24 * 60 * 60),
        accuracy: 81,
        speed: 73
    ),
    PerformedExerciseStat(
        id: 13,
        name: "Eye Focus Drill",
        performedOn: Date(timeIntervalSinceNow: -21 * 24 * 60 * 60),
        accuracy: 78,
        speed: 68
    ),
    PerformedExerciseStat(
        id: 14,
        name: "Peripheral Vision",
        performedOn: Date(timeIntervalSinceNow: -21 * 24 * 60 * 60),
        accuracy: 76,
        speed: 66
    ),
    PerformedExerciseStat(
        id: 15,
        name: "Color Recognition",
        performedOn: Date(timeIntervalSinceNow: -21 * 24 * 60 * 60),
        accuracy: 79,
        speed: 69
    )
]

