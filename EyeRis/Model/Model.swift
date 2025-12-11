//
//  Model.swift
//  EyeRis
//
//  Created by SDC-USER on 24/11/25.
//

import Foundation

struct User{
    var firstName: String
    var lastName: String
    var gender: String
    var dob: Date
    var eyeHealthData: UserEyeHealthData
}

struct UserEyeHealthData{
    // Store all the onboarding data
    
    
    // the eye conditions that the user is facing
    var condition: [Conditions] // think about this, if this has to be here on in userdata
    
    func getUserEyeConditions() -> [Conditions]{
        var conditions: [Conditions] = []
        return conditions
    }
}

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

enum Conditions{ // more conditions to be added, research needed
    case dryEyes
    case eyeFatigue
    case blurredVision
    case wateryEyes
}

struct EyeTips{
    var tip: String
    var condition: [Conditions]
}

struct PerformedExerciseStat {
    var id: Int
    var name: String
    var performedOn: Date
    var accuracy: Int
    var speed: Int
}

struct ExerciseHistory{
//    func avgSpeed() -> Int {}
//    func avgAccuracy() -> Int{}
    var date: Date // these would be replaced by functions when the data is dynamic
    var avgSpeed: Int
    var avgAccuracy: Int
    var comment: String = "Your eye coordination looks good. Regular exercise and care will maintain your eye health."
    var exercisesDetails: [PerformedExerciseStat]
}

struct AcuityScore{ // need to change this (research needed)
    var temp: String
    
    func calcScore () {
        // should return the score of the test
    }
}

enum acuityTestType{
    case NearVision
    case DistantVision
}

struct AcuityTestResult{
//     put the details for the snellen chart, and respective score details in the score struct
    var id: Int
    var testType: acuityTestType
    var testDate: Date
    var heathyScore: String
    var leftEyeScore: String // the format of scores would later change, kept it string for dummy data
    var rightEyeScore: String
    var comment: String = "Overall, your vision is fairly good, but a routine eye check-up or corrective lens may help improve clarity, especially for distance vision."
}

struct BlinkRateTest{
    var instructions: TestInstruction
    var passages: [String]
    var duration: Int = 120
}

struct TestInstruction{
//    var title: String
    var description: [String]
    var images: [String]
}


// Helper to create a Date like makeDate(year: 2025, month: 5, day: 8)
func makeDate(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
}


