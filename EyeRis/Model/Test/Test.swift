//
//  Test.swift
//  EyeRis
//
//  Created by SDC-USER on 12/12/25.
//

import Foundation

struct AcuityScore{ // need to change this (research needed)
    var temp: String
    func calcScore () {
        // should return the score of the test
    }
}

enum AcuityTestType{
    case NearVision
    case DistantVision
}

struct SnellenStep {
    let image: String
    let value: String
}

struct SnellenChart {
    let sequence: [SnellenStep]
}

struct TestInstruction{
//  var title: String
    var description: [String]
    var images: [String]
}

struct AcuityTest {
    var testType: AcuityTestType
    var instruction: TestInstruction
    var snellenChart: SnellenChart
}

struct AcuityTestResult{
//  put the details for the snellen chart, and respective score details in the score struct
    var id: Int
    var testType: AcuityTestType
    var testDate: Date
    var heathyScore: String
    var leftEyeScore: String // the format of scores would later change, kept it string for dummy data
    var rightEyeScore: String
    var comment: String = "Overall, your vision is fairly good, but a routine eye check-up or corrective lens may help improve clarity, especially for distance vision."
}

struct AcuityTestsForADate {
    let date: Date
    let distant: AcuityTestResult
    let near: AcuityTestResult
}

struct AcuityTestResultResponse {
    var results : [AcuityTestResult]
    
    init() {
        results = dummyAcuityResults
    }
    
    func groupTestsByDate() -> [AcuityTestsForADate] {
        // 1. Group every test result by its testDate
        let grouped = Dictionary(grouping: results, by: { $0.testDate })
        
        // 2. Sort dates in ascending order
        let sortedDates = grouped.keys.sorted()
        
        var dailyTests: [AcuityTestsForADate] = []
        
        // 3. Build a DailyAcuityTests object for each date
        for date in sortedDates {
            guard let items = grouped[date] else { continue }
            
            // Must have BOTH tests for that date
            guard
                let distant = items.first(where: { $0.testType == .DistantVision }),
                let near    = items.first(where: { $0.testType == .NearVision })
            else {
                continue
            }
            
            dailyTests.append(
                AcuityTestsForADate(date: date, distant: distant, near: near)
            )
        }
        
        return dailyTests
    }
}

struct BlinkRateTest{
    var instructions: TestInstruction
    var passages: [String]
    var duration: Int = 120
}

struct BlinkRateTestResult {
    var id: Int
    var blinks: Int
    var bpm: Int {
        blinks/2
    }
    var performedOn: Date
}

struct BlinkWeek {
    let startDate: Date
    let days: [BlinkRateTestResult?] // count = 7
}

struct BlinkRateTestResultResponse {
    private let results: [BlinkRateTestResult]

    init(results: [BlinkRateTestResult] = blinkRateMockData) {
        self.results = results
    }

    // Today
    func todayResult() -> BlinkRateTestResult? {
        results.first {
            Calendar.current.isDateInToday($0.performedOn)
        }
    }

    // Last 4 Weeks
    func makeLast4Weeks() -> [BlinkWeek] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let byDate = Dictionary(
            uniqueKeysWithValues: results.map {
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

            weeks.append(
                BlinkWeek(startDate: weekStart, days: days)
            )
        }

        return weeks
    }
}
