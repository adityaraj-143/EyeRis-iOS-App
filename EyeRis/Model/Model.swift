//
//  Model.swift
//  EyeRis
//
//  Created by SDC-USER on 24/11/25.
//

import Foundation

enum Conditions {
    case dryEyes
    case eyeFatigue
    case blurredVision
    case wateryEyes

    /// Human-readable text for UI
    var displayText: String {
        switch self {
        case .dryEyes: return "Dry Eyes"
        case .eyeFatigue: return "Eye Fatigue"
        case .blurredVision: return "Blurred Vision"
        case .wateryEyes: return "Watery Eyes"
        }
    }
}


//MARK: COMMENT & TIP
// to get the comment for either test or exercise based on the details passed as params
struct Comment {
    var exerciseComments: [String]
    var testComments: [String]
    
    func getComment(accuracy: Int, speed: Int) -> String{
        
        return exerciseComments[Int.random(in: 0..<exerciseComments.count)]
    }
    
    func getComment(testScore: [Int]) -> String {
        return testComments[Int.random(in: 0..<testComments.count)]
    }
}

struct EyeTips{
    var tip: String
    var condition: [Conditions]
}



//MARK: DATE HELPER
// Helper to create a Date like makeDate(year: 2025, month: 5, day: 8)
func makeDate(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
}


