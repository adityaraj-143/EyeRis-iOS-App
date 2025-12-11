//
//  DataStore.swift
//  EyeRis
//
//  Created by SDC-USER on 25/11/25.
//

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
