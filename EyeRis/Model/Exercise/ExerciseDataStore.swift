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
    // Today (2 exercises → 90+ avg)
    PerformedExerciseStat(id: 1, name: "Eye Focus Drill", performedOn: Date(), accuracy: 94, speed: 91),
    PerformedExerciseStat(id: 2, name: "Blink Control", performedOn: Date(), accuracy: 92, speed: 90),

    // 2 days ago (3 exercises → 80+ avg)
    PerformedExerciseStat(id: 3, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -2*24*60*60), accuracy: 86, speed: 82),
    PerformedExerciseStat(id: 4, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -2*24*60*60), accuracy: 84, speed: 80),
    PerformedExerciseStat(id: 5, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -2*24*60*60), accuracy: 85, speed: 81),

    // 4 days ago (1 exercise → <75)
    PerformedExerciseStat(id: 6, name: "Color Recognition", performedOn: Date(timeIntervalSinceNow: -4*24*60*60), accuracy: 73, speed: 70),

    // 7 days ago (4 exercises → 80+ avg)
    PerformedExerciseStat(id: 7, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 88, speed: 84),
    PerformedExerciseStat(id: 8, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 85, speed: 82),
    PerformedExerciseStat(id: 9, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 86, speed: 83),
    PerformedExerciseStat(id: 10, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 84, speed: 81),

    // 9 days ago (2 exercises → <75 avg)
    PerformedExerciseStat(id: 11, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -9*24*60*60), accuracy: 74, speed: 71),
    PerformedExerciseStat(id: 12, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -9*24*60*60), accuracy: 72, speed: 69),


    // 14 days ago (5 exercises → 90+ avg)
    PerformedExerciseStat(id: 13, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 93, speed: 91),
    PerformedExerciseStat(id: 14, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 92, speed: 90),
    PerformedExerciseStat(id: 15, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 94, speed: 92),
    PerformedExerciseStat(id: 16, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 91, speed: 89),
    PerformedExerciseStat(id: 17, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 93, speed: 90),

    // 16 days ago (1 exercise → 80+)
    PerformedExerciseStat(id: 18, name: "Color Recognition", performedOn: Date(timeIntervalSinceNow: -16*24*60*60), accuracy: 82, speed: 79),

    // 21 days ago (6 exercises → <75 avg)
    PerformedExerciseStat(id: 19, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 74, speed: 70),
    PerformedExerciseStat(id: 20, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 73, speed: 69),
    PerformedExerciseStat(id: 21, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 72, speed: 68),
    PerformedExerciseStat(id: 22, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 71, speed: 67),
    PerformedExerciseStat(id: 23, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 73, speed: 69),
    PerformedExerciseStat(id: 24, name: "Color Recognition", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 72, speed: 68),

    // 23 days ago (3 exercises → 80+ avg)
    PerformedExerciseStat(id: 25, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -23*24*60*60), accuracy: 85, speed: 82),
    PerformedExerciseStat(id: 26, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -23*24*60*60), accuracy: 87, speed: 83),
    PerformedExerciseStat(id: 27, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -23*24*60*60), accuracy: 84, speed: 81)
]


