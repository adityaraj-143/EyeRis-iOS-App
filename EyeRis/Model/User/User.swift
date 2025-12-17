//
//  User.swift
//  EyeRis
//
//  Created by SDC-USER on 17/12/25.
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
        return condition
    }
    
    var primaryConditionText: String {
        condition.first?.displayText ?? "None"
    }
}

