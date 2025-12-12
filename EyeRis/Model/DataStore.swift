//
//  DataStore.swift
//  EyeRis
//
//  Created by SDC-USER on 25/11/25.
//

import Foundation

// Dummy data for Test Results
let dummyAcuityResults: [AcuityTestResult] = [
    // 1) May 8, 2025
    AcuityTestResult(
        id: 1,
        testType: .DistantVision,
        testDate: makeDate(year: 2025, month: 5, day: 8),
        heathyScore: "20/25",
        leftEyeScore: "15/25",
        rightEyeScore: "15/25"
    ),
    AcuityTestResult(
        id: 2,
        testType: .NearVision,
        testDate: makeDate(year: 2025, month: 5, day: 8),
        heathyScore: "20/25",
        leftEyeScore: "20/25",
        rightEyeScore: "20/25"
    ),

    // 2) April 25, 2025
    AcuityTestResult(
        id: 3,
        testType: .DistantVision,
        testDate: makeDate(year: 2025, month: 4, day: 25),
        heathyScore: "20/25",
        leftEyeScore: "18/25",
        rightEyeScore: "18/25"
    ),
    AcuityTestResult(
        id: 4,
        testType: .NearVision,
        testDate: makeDate(year: 2025, month: 4, day: 25),
        heathyScore: "20/25",
        leftEyeScore: "20/25",
        rightEyeScore: "20/25"
    ),

    // 3) April 2, 2025
    AcuityTestResult(
        id: 5,
        testType: .DistantVision,
        testDate: makeDate(year: 2025, month: 4, day: 2),
        heathyScore: "20/25",
        leftEyeScore: "20/30",
        rightEyeScore: "20/25"
    ),
    AcuityTestResult(
        id: 6,
        testType: .NearVision,
        testDate: makeDate(year: 2025, month: 4, day: 2),
        heathyScore: "20/25",
        leftEyeScore: "20/25",
        rightEyeScore: "20/25"
    ),

    // 4) March 18, 2025
    AcuityTestResult(
        id: 7,
        testType: .DistantVision,
        testDate: makeDate(year: 2025, month: 3, day: 18),
        heathyScore: "20/25",
        leftEyeScore: "20/40",
        rightEyeScore: "20/30"
    ),
    AcuityTestResult(
        id: 8,
        testType: .NearVision,
        testDate: makeDate(year: 2025, month: 3, day: 18),
        heathyScore: "20/25",
        leftEyeScore: "20/30",
        rightEyeScore: "20/25"
    ),

    // 5) March 1, 2025
    AcuityTestResult(
        id: 9,
        testType: .DistantVision,
        testDate: makeDate(year: 2025, month: 3, day: 1),
        heathyScore: "20/25",
        leftEyeScore: "20/25",
        rightEyeScore: "20/30"
    ),
    AcuityTestResult(
        id: 10,
        testType: .NearVision,
        testDate: makeDate(year: 2025, month: 3, day: 1),
        heathyScore: "20/25",
        leftEyeScore: "20/25",
        rightEyeScore: "20/25"
    ),

    // 6) February 10, 2025
    AcuityTestResult(
        id: 11,
        testType: .DistantVision,
        testDate: makeDate(year: 2025, month: 2, day: 10),
        heathyScore: "20/25",
        leftEyeScore: "20/30",
        rightEyeScore: "20/30"
    ),
    AcuityTestResult(
        id: 12,
        testType: .NearVision,
        testDate: makeDate(year: 2025, month: 2, day: 10),
        heathyScore: "20/25",
        leftEyeScore: "20/25",
        rightEyeScore: "20/25"
    )
]


// Dummy data for Exercise History
let dummyExerciseHistory: [ExerciseHistory] = [
    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 12),
        avgSpeed: 88,
        avgAccuracy: 69,
        comment: "Your eye coordination looks good. Regular exercise and care will maintain your eye health.",
        exercisesDetails: [
            PerformedExerciseStat(id: 1, name: "Figure-8", performedOn: makeDate(year: 2025, month: 5, day: 12), accuracy: 78, speed: 83),
            PerformedExerciseStat(id: 2, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 5, day: 12), accuracy: 74, speed: 81),
            PerformedExerciseStat(id: 3, name: "Saccadic Movement", performedOn: makeDate(year: 2025, month: 5, day: 12), accuracy: 76, speed: 87),
            PerformedExerciseStat(id: 4, name: "Focus Shifting", performedOn: makeDate(year: 2025, month: 5, day: 12), accuracy: 75, speed: 91),
            PerformedExerciseStat(id: 5, name: "Light Adaption", performedOn: makeDate(year: 2025, month: 5, day: 12), accuracy: 77, speed: 85)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 13),
        avgSpeed: 86,
        avgAccuracy: 71,
        comment: "Good progress. Your stability is improving day by day.",
        exercisesDetails: [
            PerformedExerciseStat(id: 6, name: "Figure-8", performedOn: makeDate(year: 2025, month: 5, day: 13), accuracy: 80, speed: 85),
            PerformedExerciseStat(id: 7, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 5, day: 13), accuracy: 72, speed: 83),
            PerformedExerciseStat(id: 8, name: "Focus Shifting", performedOn: makeDate(year: 2025, month: 5, day: 13), accuracy: 75, speed: 88)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 14),
        avgSpeed: 89,
        avgAccuracy: 73,
        comment: "Excellent tracking improvement.",
        exercisesDetails: [
            PerformedExerciseStat(id: 9, name: "Saccadic Movement", performedOn: makeDate(year: 2025, month: 5, day: 14), accuracy: 78, speed: 90),
            PerformedExerciseStat(id: 10, name: "Figure-8", performedOn: makeDate(year: 2025, month: 5, day: 14), accuracy: 75, speed: 86)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 15),
        avgSpeed: 84,
        avgAccuracy: 70,
        comment: "Try practicing slower, controlled movements.",
        exercisesDetails: [
            PerformedExerciseStat(id: 11, name: "Focus Shifting", performedOn: makeDate(year: 2025, month: 5, day: 15), accuracy: 72, speed: 84),
            PerformedExerciseStat(id: 12, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 5, day: 15), accuracy: 68, speed: 82),
            PerformedExerciseStat(id: 13, name: "Light Adaption", performedOn: makeDate(year: 2025, month: 5, day: 15), accuracy: 70, speed: 86)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 16),
        avgSpeed: 90,
        avgAccuracy: 76,
        comment: "Strong performance. Keep maintaining consistency!",
        exercisesDetails: [
            PerformedExerciseStat(id: 14, name: "Figure-8", performedOn: makeDate(year: 2025, month: 5, day: 16), accuracy: 82, speed: 92),
            PerformedExerciseStat(id: 15, name: "Saccadic Movement", performedOn: makeDate(year: 2025, month: 5, day: 16), accuracy: 75, speed: 88),
            PerformedExerciseStat(id: 16, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 5, day: 16), accuracy: 78, speed: 90)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 5),
        avgSpeed: 83,
        avgAccuracy: 67,
        comment: "Your focus is gradually improving.",
        exercisesDetails: [
            PerformedExerciseStat(id: 17, name: "Light Adaption", performedOn: makeDate(year: 2025, month: 5, day: 5), accuracy: 70, speed: 82),
            PerformedExerciseStat(id: 18, name: "Saccadic Movement", performedOn: makeDate(year: 2025, month: 5, day: 5), accuracy: 66, speed: 85)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 6),
        avgSpeed: 84,
        avgAccuracy: 69,
        comment: "Your control over rapid eye movements is developing.",
        exercisesDetails: [
            PerformedExerciseStat(id: 19, name: "Figure-8", performedOn: makeDate(year: 2025, month: 5, day: 6), accuracy: 74, speed: 86),
            PerformedExerciseStat(id: 20, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 5, day: 6), accuracy: 68, speed: 83)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 7),
        avgSpeed: 88,
        avgAccuracy: 72,
        comment: "Eye stability is improving well.",
        exercisesDetails: [
            PerformedExerciseStat(id: 21, name: "Focus Shifting", performedOn: makeDate(year: 2025, month: 5, day: 7), accuracy: 71, speed: 87),
            PerformedExerciseStat(id: 22, name: "Figure-8", performedOn: makeDate(year: 2025, month: 5, day: 7), accuracy: 73, speed: 90)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 8),
        avgSpeed: 85,
        avgAccuracy: 70,
        comment: "Moderate consistency. Keep practicing regularly.",
        exercisesDetails: [
            PerformedExerciseStat(id: 23, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 5, day: 8), accuracy: 69, speed: 86),
            PerformedExerciseStat(id: 24, name: "Light Adaption", performedOn: makeDate(year: 2025, month: 5, day: 8), accuracy: 71, speed: 84)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 5, day: 9),
        avgSpeed: 92,
        avgAccuracy: 77,
        comment: "Great improvement in speed!",
        exercisesDetails: [
            PerformedExerciseStat(id: 25, name: "Saccadic Movement", performedOn: makeDate(year: 2025, month: 5, day: 9), accuracy: 79, speed: 93),
            PerformedExerciseStat(id: 26, name: "Figure-8", performedOn: makeDate(year: 2025, month: 5, day: 9), accuracy: 75, speed: 90)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 4, day: 22),
        avgSpeed: 82,
        avgAccuracy: 66,
        comment: "Try practicing longer sessions.",
        exercisesDetails: [
            PerformedExerciseStat(id: 27, name: "Focus Shifting", performedOn: makeDate(year: 2025, month: 4, day: 22), accuracy: 65, speed: 80),
            PerformedExerciseStat(id: 28, name: "Figure-8", performedOn: makeDate(year: 2025, month: 4, day: 22), accuracy: 68, speed: 84)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 4, day: 23),
        avgSpeed: 88,
        avgAccuracy: 73,
        comment: "Excellent progress in tracking.",
        exercisesDetails: [
            PerformedExerciseStat(id: 29, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 4, day: 23), accuracy: 75, speed: 88),
            PerformedExerciseStat(id: 30, name: "Light Adaption", performedOn: makeDate(year: 2025, month: 4, day: 23), accuracy: 71, speed: 90)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 4, day: 24),
        avgSpeed: 90,
        avgAccuracy: 78,
        comment: "Your reflexes are becoming stronger.",
        exercisesDetails: [
            PerformedExerciseStat(id: 31, name: "Saccadic Movement", performedOn: makeDate(year: 2025, month: 4, day: 24), accuracy: 80, speed: 92),
            PerformedExerciseStat(id: 32, name: "Figure-8", performedOn: makeDate(year: 2025, month: 4, day: 24), accuracy: 76, speed: 88)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 4, day: 25),
        avgSpeed: 87,
        avgAccuracy: 72,
        comment: "Your consistency is improving.",
        exercisesDetails: [
            PerformedExerciseStat(id: 33, name: "Focus Shifting", performedOn: makeDate(year: 2025, month: 4, day: 25), accuracy: 70, speed: 85),
            PerformedExerciseStat(id: 34, name: "Smooth Pursuit", performedOn: makeDate(year: 2025, month: 4, day: 25), accuracy: 74, speed: 89)
        ]
    ),

    ExerciseHistory(
        date: makeDate(year: 2025, month: 4, day: 26),
        avgSpeed: 86,
        avgAccuracy: 71,
        comment: "Good tracking and control.",
        exercisesDetails: [
            PerformedExerciseStat(id: 35, name: "Light Adaption", performedOn: makeDate(year: 2025, month: 4, day: 26), accuracy: 70, speed: 88),
            PerformedExerciseStat(id: 36, name: "Figure-8", performedOn: makeDate(year: 2025, month: 4, day: 26), accuracy: 72, speed: 84)
        ]
    )
]

